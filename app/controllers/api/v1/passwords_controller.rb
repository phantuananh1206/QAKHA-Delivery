class Api::V1::PasswordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def forgot
    if params[:email].blank?
      return render json: {message: 'Email not present'}
    end

    user = User.find_by(email: params[:email].downcase)

    if user.present?
      user.generate_password_token!
      UserMailer.password_forgot(user).deliver
      render json: {message: 'Please check your email and received code'}, status: :ok
    else
      render json: {message: 'Email address not found. Please check and try again.'}, status: :not_found
    end
  end

  def reset
    verify_code = params[:verification_code].to_s

    if params[:verification_code].blank?
      return render json: {error: 'Token not present'}, status: 404
    end
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:new_password])
        render json: {message: 'Reset password successfully'}, status: :ok
      else
        render json: {message: user.errors.full_messages}, status: :bad_request
      end
    else
      render json: {message: 'Code not valid or expired. Try generating a new code.'}, status: :not_found
    end
  end

  private

  def user_params
    params.permit :email, :new_password, :verification_code
  end
end
