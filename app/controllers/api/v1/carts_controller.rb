class Api::V1::CartsController < Api::V1::ApplicationController
  include Api::V1::CartsHelper

  before_action :load_user, :load_cart, :load_partner
  before_action :load_product, only: %i(create update destroy)

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
    render json: { carts: @carts, total_price_cart: total_price_cart }, status: :created
  end

  def update
    if @cart.present?
      @cart[0].update(quantity: params[:quantity].to_i)
      load_carts
    else
      render json: { message: 'Update product in cart failed' }, status: :bad_request
    end
  end

  def destroy
    if @cart.present?
      Cart.destroy(@cart[0][:id].to_i)
      load_carts
    else
      render json: { message: 'Delete product in cart failed' }, status: :bad_request
    end
  end

  def clear_cart
    Cart.where(user_id: @current_user.id, partner_id: params[:partner_id]).delete_all
    render json: { message: 'Clear cart success'}, status: :ok
  end

  private

  def load_product
    @product = Product.find_by(id: params[:product_id])
    return if @product && @product.category.partner_id == params[:partner_id].to_i && @product.status == "in_stock"

    render json: { message: 'Product not found!' }, status: :not_found
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
    render json: { carts: @carts, total_price_cart: total_price_cart }, status: :ok
  end

  def total_price_cart
    @total = 0
    @carts.includes(:product).each do |cart|
      @total += cart.quantity * cart.product.price
    end
    @total
  end
end
