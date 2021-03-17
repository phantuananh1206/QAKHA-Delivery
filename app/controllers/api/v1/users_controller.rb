class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: %i(show)

  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user.as_json(except: [:password]), status: 200
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    render json: {}, status: :not_found
  end
end
