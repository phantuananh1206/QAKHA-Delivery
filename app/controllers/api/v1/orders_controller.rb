class Api::V1::OrdersController < Api::V1::ApplicationController
  include Api::V1::CartsHelper
  include Api::V1::OrdersHelper

  before_action :load_user
  before_action :load_cart, except: %i(coins_user index)
  before_action :load_partner, except: %i(list_vouchers coins_user index)
  before_action :load_voucher, only: :apply_voucher
  before_action :remove_voucher, only: :cancel_voucher
  before_action :current_voucher, except: %i(coins_user index)
  before_action :check_coins_user, :find_driver_nearest, only: :create

  def create
    @order = @current_user.orders.new(order_params)
    if $current_voucher.blank? || valid_voucher?
      ActiveRecord::Base.transaction do
        save_ordered_products
        @order.save!
        save_success
      end
    else
      $current_voucher = {}
      render json: { message: 'Voucher not valid' }, status: :bad_request
    end
  rescue
    render json: { message: 'Create order failed' }, status: :bad_request
  end

  def index
    @order_history = @current_user.orders._created_at_desc.includes(:driver, :partner)
    @order_history.each do |order|
      feedbacks = Feedback.where(order_id: order.id, user_id: order.user_id)
      if feedbacks&.size == 2
        order.update(rate_status: :rated)
      end
    end
    render json: @order_history.as_json(include: [driver: { only: [:name, :image] },
      partner: { only: [:name, :address, :image] }, user: { only: [:image] }]) , status: :ok
  end

  def list_vouchers
    @vouchers = Voucher.all
    render json: @vouchers, status: :ok
  end

  def vouchers_by_partner
    @vouchers_by_partner = Voucher.where(partner_id: @partner.id, status: :effective)
    render json: @vouchers_by_partner, status: :ok
  end

  def apply_voucher
    if params[:distance].blank?
      if @voucher.effective? && @voucher.order_valid_voucher(total_price_cart)
        $current_voucher = @voucher
        render json: { voucher: @voucher, subtotal: total_price_cart, total_after_discount: total_after_discount }, status: :ok
      else
        render json: { message: 'Voucher not valid' }, status: :bad_request
      end
    else
      $distance = params[:distance].to_f
      if @voucher.condition.blank?
        if @voucher.effective? && @voucher.order_valid_voucher_distance($distance)
          $current_voucher = @voucher
          render json: { voucher: @voucher, subtotal: total_price_cart, total_after_discount: total_after_discount }, status: :ok
        else
          render json: { message: 'Voucher not valid' }, status: :bad_request
        end
      else
        if @voucher.effective? && @voucher.order_valid_voucher_distance($distance) && @voucher.order_valid_voucher(total_price_cart)
          $current_voucher = @voucher
          render json: { voucher: @voucher, subtotal: total_price_cart, total_after_discount: total_after_discount }, status: :ok
        else
          render json: { message: 'Voucher not valid' }, status: :bad_request
        end
      end
    end
  rescue StandardError
    render json: { message: 'Voucher not valid' }, status: :bad_request
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

  private

  def valid_voucher?
    return unless $current_voucher

    if $current_voucher.distance_condition.blank?
      Voucher.find_by(id: $current_voucher.id, partner_id: params[:partner_id].to_i)&.order_valid_voucher(total_price_cart)
    elsif $current_voucher.condition.blank?
      Voucher.find_by(id: $current_voucher.id, partner_id: params[:partner_id].to_i)&.order_valid_voucher_distance($distance)
    elsif $current_voucher.distance_condition.present? && $current_voucher.condition.present?
      voucher = Voucher.find_by(id: $current_voucher.id, partner_id: params[:partner_id].to_i)
      return voucher if voucher.order_valid_voucher_distance($distance) && voucher.order_valid_voucher(total_price_cart)
    end
  end

  def load_voucher
    return if @voucher = Voucher.find_by(code: params[:code], partner_id: params[:partner_id].to_i)

    $current_voucher = {}
    render json: { message: 'Voucher not found' }, status: :not_found
  end

  def total_price_cart
    @total = 0
    @carts.includes(:product).each do |cart|
      @total += cart.quantity * cart.product.price
    end
    @total
  end

  def load_cart
    @carts = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id])
    return if @carts.present?

    render json: { message: 'The cart has been changed' }, status: :bad_request
  end

  def remove_voucher
    @voucher = Voucher.find_by(id: params[:voucher_id])
    return if @voucher && @partner

    render json: { message: 'Voucher not found' }, status: :not_found
  end

  def order_params
    params.permit(:name, :phone_number, :address)
          .merge(subtotal: total_price_cart, discount: params[:discount],
                 shipping_fee: params[:shipping_fee].to_f, total: total_order,
                 type_checkout: Order.type_checkouts[params[:type_checkout]],
                 refund_coins: order_refund_coins, driver_id: find_driver_nearest['id'],
                 voucher_id: params[:voucher_id], partner_id: @partner.id)
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
    if $current_voucher
      total -= $current_voucher[:discount].to_f
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
    order = FireBase.new.update("drivers/shipping/order/#{@driver['id']}", { driver_id: @driver['id'], order_id: @order.id })
    driver = Driver.find_by(id: @driver['id'])
    driver.ship!
    render json: { order: @order.as_json(include: [user: { only: [:name, :image] }]),
      order_details: @order.order_details.includes(:product).as_json(include: [product: { only: [:name, :quantity_sold, :price, :image] }]),
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
    @drivers_can_ship = Driver.by_ids(@drivers.pluck('id'))._can_ship
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
      if nearest <= 10.00
        @driver
      else
        render json: { message: 'Sorry, the drivers are busy, please try again later.'}, status: :not_found
      end
    else
      render json: { message: 'Sorry, the drivers are busy, please try again later.'}, status: :not_found
    end
  rescue
    render json: { message: 'Sorry, the drivers are busy, please try again later.'}, status: :not_found
  end

  def check_coins_user
    if params[:type_checkout] == 'coins'
      return if @current_user.coins >= total_order

      render json: { message: 'The coin in the current wallet is not enough to pay the order' }, status: :bad_request
    end
  end

  def order_refund_coins
    if params[:type_checkout] == 'coins' && total_order >= 50000
      refund_coins = total_order * 1 / 100
    end
  end
end
