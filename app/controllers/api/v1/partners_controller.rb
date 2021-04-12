class Api::V1::PartnersController < ApplicationController
  respond_to :json

  def index
    @partners = Partner.all
    render json: @partners.as_json(except: [:password], include: [:categories => {:include => :products}])
  end
end
