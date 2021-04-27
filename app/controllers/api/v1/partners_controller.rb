class Api::V1::PartnersController < ApplicationController
  respond_to :json

  def index
    @partners = Partner.all
    render json: @partners.as_json(except: [:password], include: [:categories => {:include => :products}])
  end

  def show_partner
    @partner = Partner.find_by(id: params[:id])
    if @partner.present?
      render json: { partner: @partner,
                     avg_point: @partner.avg_point_feedback_partner,
                     number_of_reviews: @partner.number_of_reviews }, status: :ok
    else
      render json: { message: 'Partners not found' }, status: :not_found
    end
  end
end
