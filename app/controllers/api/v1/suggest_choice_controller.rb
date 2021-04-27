class Api::V1::SuggestChoiceController < ApplicationController
  include Api::V1::OrdersHelper

  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :suggest_partners_nearest

  def suggest_partners
    @partners = Partner._partner_valid
    if @partners.present?
      render json: @partners.select("partners.id, status, name, avg(point) as average_point, count(partner_id) as number_of_reviews, time_open, time_close")
                            .group("partners.id, name, time_open, time_close")
                            .order("count(partner_id) DESC, avg(point) DESC")
                            .joins(:feedbacks).where(feedbacks: { driver_id: nil })
                            .limit(5), status: :ok
    else
      render json: { message: 'Partners not found' }, status: :not_found
    end
  end

  def suggest_partners_nearby
    @list_partners = Partner._partner_open
    @partners = []
    if @list_partners.present?
      @list_partners.each do |partner|
        distance = getDistanceFromLatLongInKm(params[:latitude].to_f, params[:longitude].to_f, partner.latitude, partner.longitude)
        if distance < 5.0
          @partners << add_infor_partner(partner, distance)
        end
      end
      render json: @partners.sort_by { |partner| partner[:distance] }, status: :ok
    else
      render json: { message: 'Partners not found' }, status: :not_found
    end
  end

  private
  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { message: ['Not Authenticated'] }, status: :unauthorized
  end

  def add_infor_partner(partner, distance)
    { id: partner.id, name: partner.name, address: partner.address,
      phone_number: partner.phone_number, email: partner.email,
      time_open: partner.time_open, time_close: partner.time_close,
      status: partner.status, latitude: partner.latitude, longitude: partner.longitude,
      image: partner.image, city_id: partner.city_id, type_id: partner.type_id,
      distance: distance }
  end
end
