class Api::V1::ApplicationsController < ApplicationController::API
  skip_before_action :verify_authenticity_token

  respond_to :json
end
