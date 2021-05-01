class Api::V1::FeedbacksController < ApplicationController
  include Api::V1::CartsHelper

  skip_before_action :verify_authenticity_token
  before_action :load_user, :load_order, :user_can_feedback, only: :create
  before_action :load_partner, only: :fb_partner
  before_action :load_driver, only: :fb_driver

  def create
    @feedback = @current_user.feedbacks.new(feedback_params)
    if @order.rate? && feedback_valid? && @feedback.save
      if params[:image].present?
        @feedback.save_image!(params[:image])
      end
      render json: @feedback, status: :created
    else
      render json: { message: 'Feedback failed' }
    end
  end

  def fb_partner
    render json: { feedbacks: @partner.feedbacks._feedback_partner.as_json(include: [user: { only: [:name, :image] }]),
                   avg_point: @partner.avg_point_feedback_partner,
                   number_of_reviews: @partner.number_of_reviews }, status: :ok
  end

  def fb_driver
    render json: { feedbacks: @driver.feedbacks.as_json(include: [user: { only: [:name, :image] }]), avg_point: @driver.avg_point_feedback_driver }, status: :ok
  end

  def check_feedback_driver
    if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!
      @feedback = Feedback.find_by(order_id: params[:order_id], user_id: @current_user.id)
      if @feedback && @feedback.driver_id.present?
        render json: { rated_driver: true }, status: :ok
      else
        render json: { rated_driver: false }, status: :ok
      end
    end

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { message: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def feedback_params
    params.permit(:content, :image, :point, :order_id, :partner_id, :driver_id)
  end

  def load_order
    if params[:driver_id].blank?
      return if @order = Order.find_by(id: params[:order_id], partner_id: params[:partner_id], status: :completed)
    else
      return if @order = Order.find_by(id: params[:order_id], driver_id: params[:driver_id],
        partner_id: params[:partner_id], status: :completed)
    end

    render json: { message: 'Order not found' }, status: :not_found
  end

  def feedback_valid?
    @feedbacks = Feedback.where(order_id: params[:order_id], user_id: @current_user.id)
    return unless @feedbacks

    @feedbacks.size < 2
  end

  def user_can_feedback
    return if @current_user.id == @order.user_id

    render json: { message: "Current user can't feedback"}, status: :bad_request
  end

  def load_driver
    return if @driver = Driver.find_by(id: params[:driver_id])

    render json: { message: 'Driver not found' }, status: :not_found
  end

  def load_partner
    return if @partner = Partner.find_by(id: params[:partner_id])

    render json: { message: 'Partner not found' }, status: :not_found
  end
end
