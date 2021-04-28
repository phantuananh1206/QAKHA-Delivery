class Api::V1::OrdersController < ApplicationController
  include Api::V1::CartsHelper
  include Api::V1::OrdersHelper

  skip_before_action :verify_authenticity_token
  before_action :load_user
  before_action :load_cart, except: %i(coins_user index)
  before_action :load_partner, except: %i(list_vouchers coins_user index)
  before_action :load_voucher, only: :apply_voucher
  before_action :remove_voucher, only: :cancel_voucher
  before_action :current_voucher, except: %i(coins_user index)
  before_action :find_driver_nearest, only: :create

  def create
    @order = @current_user.orders.new(order_params)
    if $current_voucher.blank? || valid_voucher?
      ActiveRecord::Base.transaction do
        save_ordered_products
        @order.save!
        save_success
      end
    else
      session.delete(:voucher)
      render json: { message: 'Voucher not valid' }, status: :bad_request
    end
  rescue
    render json: { message: 'Create order failed' }, status: :bad_request
  end

  def index
    @order_history = @current_user.orders._created_at_desc
    @order_history.each do |order|
      feedbacks = Feedback.where(order_id: order.id, user_id: order.user_id)
      if feedbacks&.size == 2
        order.update(rate_status: :rated)
      end
    end
    render json: @order_history.as_json(include: [driver: { only: [:name, :image] },
      partner: { only: [:name, :address, :image] }]) , status: :ok
  end

  def list_vouchers
    @vouchers = Voucher.all
    render json: @vouchers, status: :ok
  end

  def vouchers_by_partner
    @vouchers_by_partner = Voucher.where(partner_id: @partner.id)
    render json: @vouchers_by_partner, status: :ok
  end

  def apply_voucher
    if @voucher.effective? && @voucher.order_valid_voucher(total_price_cart)
      $current_voucher = @voucher
      render json: { voucher: @voucher, subtotal: total_price_cart, total_after_discount: total_after_discount }, status: :ok
    else
      render json: { message: 'Voucher not valid' }, status: :bad_request
    end
  end

  def cancel_voucher
    if $current_voucher == @voucher
      $current_voucher = {}
      render json: { message: 'Delete voucher success', subtotal: total_price_cart, total_before_discount: total_price_cart }, status: :ok
    else
      render json: { message: 'Delete voucher failed' }, status: :bad_request
    end
  end

  def location
    render json: { distance: calculate_distance, shipping_fee: calculate_shipping_fee }
  end

  def coins_user
    render json: { coins: @current_user.coins }, status: :ok
  end

  def show_infor
    render json: { order: @order.as_json(include: [order_details: { except: [:created_at, :updated_at],
      include: [product: { only: [:name] }] }, partner: { only: [:latitude, :longitude] }]),
        user: { latitude: $latitude, longitude: $longitude } },
          status: :ok
  end

  private

  def valid_voucher?
    return unless $current_voucher

    Voucher.find_by(id: $current_voucher.id, partner_id: params[:partner_id].to_i)&.order_valid_voucher(total_price_cart)
  end

  def load_voucher
    return if @voucher = Voucher.find_by(code: params[:code], partner_id: params[:partner_id].to_i)

    render json: { message: 'Voucher not found' }, status: :not_found
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

    render json: { message: 'Cart is empty' }, status: :bad_request
  end

  def remove_voucher
    @voucher = Voucher.find_by(id: params[:voucher_id])
    return if @voucher && @partner

    render json: { message: 'Voucher not found' }, status: :not_found
  end

  def order_params
    params.permit(:name, :phone_number, :address)
          .merge(subtotal: total_price_cart, discount: $current_voucher[:discount],
                 shipping_fee: params[:shipping_fee].to_f, total: total_order,
                 type_checkout: params[:type_checkout],
                 driver_id: find_driver_nearest['id'], voucher_id: $current_voucher[:id],
                 partner_id: @partner.id)
  end

  def calculate_distance
    if @partner
      distance = getDistanceFromLatLongInKm(params[:latitude].to_f, params[:longitude].to_f, @partner.latitude, @partner.longitude)
    else
      render json: { message: 'Partner not found' }, status: :not_found
    end
    distance
  end

  def calculate_shipping_fee
    shipping_fee = 15000
    if calculate_distance > 3.0
      shipping_fee += (calculate_distance - 3.0) * 5000
    end
    shipping_fee
  end

  def total_after_discount
    total = total_price_cart
    if @voucher
      total -= @voucher.discount
    else
      total
    end
  end

  def total_order
    total = total_after_discount + params[:shipping_fee].to_f
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
    order = FireBase.new.push("drivers/shipping/#{@driver['id']}/order", { driver_id: @driver['id'], order_id: @order.id })
    driver = Driver.find_by(id: @driver['id'])
    driver.ship!
    render json: { order: @order.as_json(include: [user: { only: [:name, :image] }]), order_details: @order.order_details,
      driver_nearest: driver.as_json(only: [:id, :name, :email, :id_card, :phone_number, :license_plate, :image, :status]),
      partner: @order.partner.as_json(only: [:name, :address, :image, :latitude, :longitude]),
      gps_user: { latitude: params[:latitude], longitude: params[:longitude] } }, status: :ok
    @carts.delete_all
    $current_voucher = {}
  end

  def find_driver_nearest
    @drivers2 = FireBase.new.get('drivers').body['location']['driver'].compact!
    if @drivers2.blank?
      @drivers = FireBase.new.get('drivers').body['location']['driver'].values
    else
      @drivers = @drivers2
    end
    @list_drivers = Driver.by_ids(@drivers.pluck('id'))
    @drivers_can_ship = @list_drivers._can_ship
    if @drivers_can_ship.present?
      driver_first = @drivers_can_ship.first
      min_driver = @drivers.find { |driver_fb| driver_fb['id'].to_i == driver_first.id }
      nearest = getDistanceFromLatLongInKm(min_driver['latitude'], min_driver['longitude'], @partner.latitude, @partner.longitude)
      @driver = min_driver
      @drivers_can_ship.each do |driver|
        driver_loop = @drivers.find { |driver_rt| driver_rt['id'].to_i == driver.id }
        current_distance = getDistanceFromLatLongInKm(driver_loop['latitude'], driver_loop['longitude'], @partner.latitude, @partner.longitude)
        if current_distance < nearest
          nearest = current_distance
          @driver = driver_loop
        end
      end
      @driver
    else
      render json: { message: 'Sorry, the drivers are busy, please try again later.'}, status: :not_found
    end
  rescue
    render json: { message: 'Sorry, the drivers are busy, please try again later.'}, status: :not_found
  end
end
