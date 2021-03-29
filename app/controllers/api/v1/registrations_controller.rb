class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    user = User.new user_params
    if check_email_exist(user)
      render json: {message: "Email is already exists in database"}, status: :not_found
    else
      if check_phonenumber_exist(user)
        render json: {message: "Phone Number is already exists in database"}, status: :not_found
      else
        save_user user
      end
    end
  end

  def save_user user
    if user.save
      render json: true, status: :created
    else
      warden.custom_failure!
      render json: {error: user.errors.full_messages}, status: :bad_request
    end
  end

  def check_email_exits
    user = User.new user_params
    if params[:email].present?
      if check_email_exist(user)
        render json: {message: "Email is already exists in database"}, status: :not_found
      else
        render json: true, status: :ok
      end
    else
      render json: {message: "Email is not null"}, status: :not_found
    end
  end

  def check_phone_number_exits
    user = User.new user_params
    if check_phonenumber_exist(user)
      render json: {message: "Phone Number is already exists in database"}, status: :not_found
    else
      render json: true, status: :ok
    end
  end

  private

  def check_email_exist user
    user = User.find_by_email params[:email]
    return true if user
  end

  def check_phonenumber_exist user
    user = User.find_by_phone_number params[:phone_number]
    return true if user
  end

  def user_params
    params.permit :email, :password, :password_confirmation, :name, :phone_number
  end
end
