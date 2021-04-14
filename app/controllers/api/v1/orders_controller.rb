class Api::V1::OrdersController < ApplicationController
  include Api::V1::CartsHelper
  include Api::V1::OrdersHelper

  skip_before_action :verify_authenticity_token
  before_action :load_user, :load_cart, :load_partner
  before_action :load_voucher, only: :apply_voucher
  before_action :current_voucher, only: %i(apply_voucher cancel_voucher)
  before_action :remove_voucher, only: :cancel_voucher

  def create
    @order = @current_user.orders.new(order_params)
    if current_voucher.blank? || valid_voucher?
      ActiveRecord::Base.transaction do
        save_ordered_products
        @order.save!
      end
      save_success
    else
      session.delete(:voucher)
      render json: { error: 'Voucher not valid' }
    end
  rescue
    render json: { error: 'Create order failed' }
  end

  def apply_voucher
    if @voucher.order_valid_voucher(total_price_cart)
      session[:voucher] = @voucher
      render json: { voucher: @voucher, subtotal: total_price_cart, total: total_after_discount }, status: :ok
    else
      render json: { error: 'Voucher not valid' }, status: :bad_request
    end
  end

  def cancel_voucher
    if session[:voucher] == @voucher
      session.delete(:voucher)
      @voucher = nil
      render json: { message: 'Delete voucher success', subtotal: total_price_cart, total: total_after_discount }, status: :ok
    else
      render json: { error: 'Delete voucher failed' }, status: :bad_request
    end
  end

  def location
    render json: { driver_nearest: find_driver_nearest.as_json(except: [:password]), distance: calculate_distance, shipping_fee: calculate_shipping_fee }
  end

  private

  def valid_voucher?
    return unless current_voucher

    Voucher.find_by(id: current_voucher.id)&.order_valid_voucher(total_price_cart)
  end

  def load_voucher
    return if @voucher = Voucher.find_by(code: params[:code])

    render json: { error: 'Voucher not found' }, status: :not_found
  end

  def total_price_cart
    @total = 0
    @carts.each do |cart|
      @total += cart.quantity * cart.product.price
    end
    @total
  end

  def load_cart
    return if @carts = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id])

    render json: { error: 'Cart is empty' }, status: :bad_request
  end

  def remove_voucher
    @voucher = Voucher.find_by(id: params[:voucher_id])
    return if @voucher && @partner

    render json: { error: 'Voucher not found' }, status: :not_found
  end

  def order_params
    params.permit(:name, :phone_number, :address, :delivery_time)
          .merge(subtotal: total_price_cart, discount: current_voucher[:discount],
                 total: total_after_discount, shipping_fee: calculate_shipping_fee,
                 driver_id: find_driver_nearest[:id], voucher_id: current_voucher[:id])
  end

  def calculate_distance
    if @partner
      distance = getDistanceFromLatLongInKm(params[:latitude].to_f, params[:longitude].to_f, @partner.latitude, @partner.longitude)
    else
      render json: { error: 'Partner not found' }, status: :not_found
    end
    distance
  end

  def calculate_shipping_fee
    calculate_distance * 5000
  end

  def total_after_discount
    total = total_price_cart
    if @voucher
      total -= @voucher.discount
    else
      total
    end
  end

  def save_ordered_products
    if @carts.present?
      @products = Product.by_ids(@carts.pluck(:product_id))
      @carts.each do |cart|
        product = @products.find { |product| product.id == cart.product_id }
        if product
          @order.order_details.new(product_id: product.id,
                                   quantity: cart.quantity,
                                   price: product.price)
        else
          @carts.delete(cart.id)
        end
      end
    end
  end

  def save_success
    render json: { order: @order, order_details: @order.order_details }
    @carts.delete_all
    session.delete(:voucher)
  end

  def find_driver_nearest
    drivers = Driver.where(status: :online)
    @driver = drivers.first
    nearest = getDistanceFromLatLongInKm(@driver.latitude, @driver.longitude, @partner.latitude, @partner.longitude)
    drivers.each do |driver|
      current_driver = getDistanceFromLatLongInKm(driver.latitude, driver.longitude, @partner.latitude, @partner.longitude)
      if  current_driver < nearest
        nearest = current_driver
        @driver = driver
      end
    end
    @driver
  end
end
