class Api::V1::DriversController < Api::V1::ApplicationController
  include Api::V1::DriversHelper

  before_action :load_driver
  before_action :load_order, only: %i(show_infor complete_delivery)

  def index
    render json: @current_driver.as_json(only: [:id, :name, :email, :id_card,
                                                :phone_number, :license_plate,
                                                :image, :status]), status: :ok
  end

  def show_infor
    @address = Address.find_by(user_id: @order.user_id, name: @order.address)
    if @address
      @order_details = @order.order_details.includes(:product)
      render json: { order_details: @order_details.as_json(include: [product: {only: [:name, :image] }]),
        order: @order.as_json(except: [:updated_at],
        include: [partner: { only: [:name, :address, :image, :latitude, :longitude] }]),
        location_user: { name: @address.name, latitude: @address.latitude, longitude: @address.longitude } }, status: :ok
    else
      render json: { message: 'Address not found' }, status: :not_found
    end
  end

  def update
    if params[:status] == "online" || params[:status] == "offline"
      @current_driver.send("#{params[:status]}!")
      render json: true, status: :ok
    else
      render json: false, status: :bad_request
    end
  rescue StandardError
    render json: false, status: :bad_request
  end

  def status_driver
    render json: { status: @current_driver.status }, status: :ok
  end

  def complete_delivery
    if @order.shipping? && params[:status_order] == "completed"
      ActiveRecord::Base.transaction do
        @order.update(status: :completed, rate_status: :rate, delivery_time: Time.zone.now)
        @current_driver.delivered!
        FireBase.new.delete('drivers/shipping')
      end
      render json: { order: @order.as_json(only: [:delivery_time, :status, :rate_status]),
        status_driver: @current_driver.status }, status: :ok
    else
      render json: { message: 'Order status not valid' }, status: :not_found
    end
  rescue
    render json: { message: 'Complete delivery error' }, status: :bad_request
  end

  def order_history
    @orders = @current_driver.orders._order_completed
    render json: @orders.includes(:partner, order_details: [:product]).as_json(include: [partner: { only: [:name, :address, :image] },
      order_details: { include: [product: { only: [:name, :image] }] }]), status: :ok
  end

  def coins_driver
    render json: { coins: @current_driver.coins }, status: :ok
  end

  def update_profile
    if params[:image].blank?
      params.delete(:image)
    end
    if @current_driver.update(driver_params)
      if params[:image].present?
        @current_driver.save_image!(params[:image])
      end
      render json: @current_driver.as_json(except: [:password]), status: :ok
    else
      render json: { errors: @current_driver.errors.full_messages }, status: :bad_request
    end
  end

  def change_password
    if @current_driver.valid_password?(params[:current_password])
      if @current_driver.update(password_params)
        render json: @current_driver.as_json(except: [:password]), status: :ok
      else
        render json: { errors: @current_driver.errors.full_messages }, status: :bad_request
      end
    else
      render json: { message: "Current password don't match" }, status: :bad_request
    end
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:order_id], driver_id: @current_driver.id)

    render json: { message: 'Order not found' }, status: :not_found
  end

  def driver_params
    params.permit(:name, :email, :address, :phone_number, :image)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end
end
