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
      flash[:success] = t('admin.type.create_success')
      redirect_to admin_types_path
    else
      flash.now[:danger] = t('admin.type.create_failed')
      render :new
    end
  end

  def update
    if @type.update(type_params)
      flash[:success] = t('admin.type.update_success')
      redirect_to admin_types_path
    else
      flash.now[:danger] = t('admin.type.update_failed')
      render :edit
    end
  end

  def destroy
    if @type.destroy
      flash[:success] = t('admin.type.delete_success')
    else
      flash[:danger] = t('admin.type.delete_failed')
    end
    redirect_to admin_types_path
  end

  def export
    @types = Type.order(:name)
    if @types.present?
      respond_to do |format|
        format.xls { send_data @types.to_xls }
      end
    else
      flash[:danger] = t('admin.type.empty')
      redirect_to admin_types_path
    end
  end

  private

  def type_params
    params.require(:type).permit(:name)
  end

  def load_type
    return if @type = Type.find_by(id: params[:id])

    flash[:danger] = t('admin.type.not_found')
    redirect_to admin_types_path
  end
end
