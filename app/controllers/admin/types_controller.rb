class Admin::TypesController < Admin::BaseController
  before_action :load_type, except: %i(index new create export)

  def index
    @search = Type.search(params[:q])
    @types = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      flash[:success] = 'Create type success'
      redirect_to admin_types_path
    else
      flash.now[:danger] = 'Create type failed'
      render :new
    end
  end

  def update
    if @type.update(type_params)
      flash[:success] = 'Update type success'
      redirect_to admin_types_path
    else
      flash.now[:danger] = 'Update type failed'
      render :edit
    end
  end

  def destroy
    if @type.destroy
      flash[:success] = 'Delete type success'
    else
      flash[:danger] = 'Delete type failed'
    end
    redirect_to admin_types_path
  end

  def export
    @types = Type.order(:name)
    respond_to do |format|
	    format.xls { send_data @types.to_xls }
	  end
  end

  private

  def type_params
    params.require(:type).permit(:name)
  end

  def load_type
    return if @type = Type.find_by(id: params[:id])

    flash[:danger] = 'Type not found'
    redirect_to admin_types_path
  end
end
