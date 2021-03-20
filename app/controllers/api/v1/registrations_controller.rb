class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    user = User.new user_params
    if user.save
      render json: user.as_json(except: [:password]), status: 200
    else
      warden.custom_failure!
      render json: {message: "Registration error"}, status: 200
    end
  end

  private

  def user_params
    params.permit :email, :password, :password_confirmation
  end
end
