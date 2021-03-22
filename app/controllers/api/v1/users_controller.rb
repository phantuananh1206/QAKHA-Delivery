class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :load_user, only: %i(show)

  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!
    render json: @current_user.as_json(except: [:password]), status: 200

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { error: ['Not Authenticated'] }, status: :unauthorized
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    render json: {}, status: :not_found
  end
end
