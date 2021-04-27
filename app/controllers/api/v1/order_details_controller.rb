class Api::V1::OrderDetailsController < ApplicationController
  include Api::V1::CartsHelper

  before_action :load_user, :load_order

  def index
    @order_details = @order.order_details
    render json: { order_details: @order_details.as_json(include: [product: {only: [:name, :image] }]),
      order: @order.as_json(except: [:updated_at],
      include: [partner: { only: [:name, :address, :image] }]) }, status: :ok
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:order_id], user_id: @current_user.id)

    render json: { message: 'Order not found' }, status: :not_found
  end
end
