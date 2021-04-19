class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: %i(show update)

  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @current_user.as_json(except: [:password]), status: 200
  end

  def update
    if params[:password].blank? && params[:password_confirmation].blank? && params[:image].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:image)
    end
    if @current_user.update(user_params)
      if params[:image].present?
        @current_user.save_image!(params[:image])
      end
      render json: @current_user.as_json(except: [:password]), status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:name, :email, :phone_number, :image,
                  :password, :password_confirmation)
  end

  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { message: 'Not Authenticated' }, status: :unauthorized
  end
end
