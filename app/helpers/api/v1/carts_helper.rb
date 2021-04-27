module Api::V1::CartsHelper
  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { message: ['Not Authenticated'] }, status: :unauthorized
  end

  def load_partner
    return if @partner = Partner.find_by(id: params[:partner_id], status: :open)

    render json: { message: 'Partner not found!' }, status: :not_found
  end
end
