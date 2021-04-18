class Api::V1::CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_user, :load_cart, :load_partner
  before_action :load_product, only: %i(create update destroy)

  respond_to :json

  def show
    load_carts
  end

  def create
    if @cart.present?
      @cart[0].update(quantity: (@cart[0][:quantity] + params[:quantity].to_i))
    else
      @cart = Cart.new(cart_params)
      @cart.save
    end
    @carts = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id])
    render json: @carts, status: :created
  end

  def update
    if @cart.present?
      @cart[0].update(quantity: params[:quantity].to_i)
      load_carts
    else
      render json: { error: 'Update product in cart failed' }, status: :bad_request
    end
  end

  def destroy
    if @cart.present?
      Cart.destroy(@cart[0][:id].to_i)
      load_carts
    else
      render json: { error: 'Delete product in cart failed' }, status: :bad_request
    end
  end

  def clear_cart
    Cart.where(user_id: @current_user.id, partner_id: params[:partner_id]).delete_all
    render json: { error: 'Clear cart success'}, status: :ok
  end

  private

  def load_user
    return if @current_user = Api::V1::AuthController.new(request.headers).authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { error: ['Not Authenticated'] }, status: :unauthorized
  end

  def load_product
    return if @product = Product.find_by(id: params[:product_id])

    render json: { error: 'Product not found!' }, status: :not_found
  end

  def load_cart
    @cart = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id],
                       product_id: params[:product_id])
  end

  def cart_params
    params.permit(:quantity, :product_id, :partner_id)
          .merge(user_id: @current_user.id)
  end

  def load_carts
    @carts = Cart.where(user_id: @current_user.id, partner_id: params[:partner_id])
    render json: @carts, status: :ok
  end
end
