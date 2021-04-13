class Api::V1::SessionsController < Devise::SessionsController
  before_action :load_user_authentication, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    if @user.valid_password? params[:password]
      sign_in @user, store: false
      jwt = JWT.encode(
        { user: @user.as_json(except: [:password]), exp: (Time.now + 2.hours).to_i },
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
      render json: { role: @user[:role], token: jwt }, status: :ok
      return
    end
      invalid_login_attempt
  end

  private

  def load_user_authentication
    @user = User.find_by_email params[:email]
    render json: {message: "Email is not exists. Please sign up !!"}, status: :bad_request unless @user
  end

  def user_params
    params.permit :email, :password
  end

  def invalid_login_attempt
    render json: {message: "Sign in failed"}, status: 400
  end

  def ensure_params_exist
    return unless params.blank?
     render json: {message: "Missing params"}, status: 422
   end
end
