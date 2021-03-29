class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    user = User.new user_params
    if user.save
      render json: true, status: :created
    else
      warden.custom_failure!
      render json: {error: user.errors.full_messages}, status: :bad_request
    end
  end

  private

  def user_params
    params.permit :email, :password, :password_confirmation, :name, :phone_number
  end
end
