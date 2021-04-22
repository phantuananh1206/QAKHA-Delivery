class Api::V1::DriversController < ApplicationController
  include Api::V1::DriversHelper

  skip_before_action :verify_authenticity_token
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
      render json: { order: @order.as_json(include: [order_details: { except: [:created_at, :updated_at],
        include: [product: { only: [:name, :image] }] }, partner: { only: [:name, :address, :latitude, :longitude] }]),
          location_user: { name: @address.name, latitude: @address.latitude, longitude: @address.longitude } },
            status: :ok
    else
      render json: { error: 'Address not found' }, status: :not_found
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
      render json: { error: 'Order status not valid' }, status: :not_found
    end
  rescue
    render json: { error: 'Complete delivery error' }, status: :bad_request
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:order_id], driver_id: @current_driver.id)

    render json: { error: 'Order not found' }, status: :not_found
  end
end
