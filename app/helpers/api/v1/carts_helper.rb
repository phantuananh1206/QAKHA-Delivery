module Api::V1::CartsHelper
  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { error: ['Not Authenticated'] }, status: :unauthorized
  end
end
