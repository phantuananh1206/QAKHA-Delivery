class Api::V1::TypesController < Api::V1::ApplicationController
  before_action :load_type, only: %i(show)

  def index
    @types = Type.all
    render json: @types
  end

  def show
    @partners = @type.partners.includes(categories: [:products])
    render json: @partners.as_json(except: [:password], include: [:categories => {:include => :products}])
  end

  def load_type
    return if @type = Type.find_by(id: params[:type_id])

    render json: { message: "Type not found" }, status: :not_found
  end
end
