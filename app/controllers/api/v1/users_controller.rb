class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :load_user, except: :index
  before_action :load_order, only: :tracking_order

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @current_user.as_json(except: [:password]), status: 200
  end

  def update
    if params[:image].blank?
      params.delete(:image)
    elsif params[:image].present?
      @current_user.save_image!(params[:image])
    end
    if @current_user.update(user_params)
      render json: @current_user.as_json(except: [:password]), status: :ok
    else
      render json: { message: @current_user.errors.full_messages }, status: :bad_request
    end
  end

  def orders_shipping
    @orders = Order._shipping_order(@current_user.id)
    render json: @orders.includes(:partner).as_json(include: [partner: { only: [:name, :address, :image] }]) , status: :ok
  end

  def tracking_order
    @address = Address.find_by(user_id: @order.user_id, name: @order.address)
    if @address
      render json: { order: @order.as_json(include: [user: { only: [:name, :image] }]),
      order_details: @order.order_details.includes(:product).as_json(include: [product: { only: [:name, :quantity_sold, :price, :image] }]),
      driver_nearest: @order.driver.as_json(only: [:id, :name, :email, :id_card, :phone_number, :license_plate, :image, :status]),
      partner: @order.partner.as_json(only: [:name, :address, :image, :latitude, :longitude]),
      gps_user: { name: @address.name, latitude: @address.latitude, longitude: @address.longitude } }, status: :ok
    else
      render json: { message: 'Address not found' }, status: :not_found
    end
  end

  def change_password
    if @current_user.valid_password?(params[:current_password])
      if @current_user.update(password_params)
        render json: @current_user.as_json(except: [:password]), status: :ok
      else
        render json: { message: @current_user.errors.full_messages }, status: :bad_request
      end
    else
      render json: { message: "Current password don't match" }, status: :bad_request
    end
  end

  def change_email
    if @current_user.confirmation_token == params[:code_activate]
      @current_user.update_columns(email: params[:new_email], confirmed_at: Time.zone.now)
      render json: {message: 'Change email successfully'}, status: :ok
    else
      render json: {message: 'The activation code is invalid. Please check and try again.'}, status: :not_found
    end
  end

  private

  def user_params
    params.permit(:name, :email, :phone_number, :image)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end

  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { message: 'Not Authenticated' }, status: :unauthorized
  end

  def load_order
    return if @order = Order.find_by(id: params[:order_id], user_id: @current_user.id)

    render json: { message: 'Order not found' }, status: :not_found
  end
end
