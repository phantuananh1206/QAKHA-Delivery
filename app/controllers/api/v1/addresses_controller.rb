class Api::V1::AddressesController < Api::V1::ApplicationController
  include Api::V1::CartsHelper

  before_action :load_user
  before_action :load_address, only: %i(update destroy)

  def index
    render json: @current_user.addresses, status: :ok
  end

  def create
    @address = @current_user.addresses.new(address_params)
    if @address.save
      render json: @address, status: :created
    else
      render json: { message: 'Create address failed' }
    end
  end

  def update
    if @address.update(address_params)
      render json: @address, status: :created
    else
      render json: { message: 'Create address failed' }
    end
  end

  def destroy
    if @address.destroy
      render json: { message: 'Delete address success' }
    else
      render json: { message: 'Delete address failed' }
    end
  end

  private

  def address_params
    params.permit(:name, :latitude, :longitude)
  end

  def load_address
    return if @address = Address.find_by(id: params[:id], user_id: @current_user.id)

    render json: { message: 'Address not found!' }, status: :not_found
  end
end
