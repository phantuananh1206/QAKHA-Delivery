class Api::V1::OrdersController < ApplicationController
  include Api::V1::CartsHelper
  include Api::V1::OrdersHelper

  skip_before_action :verify_authenticity_token
  before_action :load_user, :load_cart
  before_action :load_voucher, only: :apply_voucher
  before_action :current_voucher, only: %i(apply_voucher cancel_voucher)
  before_action :remove_voucher, only: :cancel_voucher

  def index
    render json: { total: total_price_cart, shipping_fee: calculate_shipping_fee }
  end

  def create
    @order = @current_user.orders.new(order_params)
  end

  def apply_voucher
    if @voucher.order_valid_voucher(total_price_cart)
      session[:voucher] = @voucher
      render json: { voucher: @voucher, total_price_products: total_price_cart, total_after_discount: total_after_discount }, status: :ok
    else
      render json: { error: 'Voucher not valid' }, status: :bad_request
    end
  end

  def cancel_voucher
    if session[:voucher] == @voucher
      session.delete(:voucher)
      @voucher = nil
      render json: { message: 'Delete voucher success' }
    else
      render json: { error: 'Delete voucher failed' }, status: :bad_request
    end
  end

  def location
    calculate_shipping_fee
  end

  private

  def valid_quantity(product, quantity)
    quantity <= product.quantity &&
      quantity >= Settings.product.min_quantity
  end

  def valid_voucher?
    return unless @voucher

    Voucher.find_by(id: @voucher.id)&.order_valid_voucher(total_price_cart)
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
    @carts = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id])
  end

  def remove_voucher
    @voucher = Voucher.find_by(id: params[:voucher_id])
    @partner = Partner.find_by(id: params[:partner_id])
    return if @voucher && @partner

    render json: { error: 'Voucher not found' }, status: :not_found
  end

  def order_params
    params.require(:order).permit(:name, :phone_number, :address, :delivery_time)
                          .merge(total_price_products: total_price_cart, shipping_fee: calculate_shipping_fee)
  end

  def calculate_shipping_fee
    shipping_fee = 0
    @partner = Partner.find_by(id: params[:partner_id])
    if @partner
      distance = getDistanceFromLatLongInKm(params[:latitude].to_f, params[:longitude].to_f, @partner.latitude, @partner.longitude)
      shipping_fee = 5000 * distance
    else
      render json: { error: 'Partner not found' }, status: :not_found
    end
    render json: { distance: distance, shipping_fee: shipping_fee }
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
    if @carts.empty?
      render json: { error: 'Car t is empty' }, status: :bad_request
    else
      @products = Product.by_ids(@carts.product_id)
      @carts.each do |cart|
        product = @products.find { |product| product.id == cart.product_id }
        if product && valid_quantity(product, quantity)
          @order.order_details.new(product_id: product.id,
                                   quantity: cart.quantity,
                                   price: product.price)
        else
          @carts.delete(cart.id)
        end
      end
    end
  end
end
