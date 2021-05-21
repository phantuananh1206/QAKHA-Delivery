class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(index new create export)
  before_action :list_partners, except: %i(index destroy export)

  def index
    @search = Category.includes(:partner).search(params[:q])
    @categories = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('admin.category.create_success')
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t('admin.category.create_failed')
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = t('admin.category.update_success')
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t('admin.category.update_failed')
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t('admin.category.delete_success')
    else
      flash[:danger] = t('admin.category.delete_failed')
    end
    redirect_to admin_categories_path
  end

  def export
    @categories = Category.order(:name)
    if @categories.present?
      respond_to do |format|
        format.xls { send_data @categories.to_xls }
      end
    else
      flash[:danger] = t('admin.category.empty')
      redirect_to admin_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :partner_id)
  end

  def load_category
    return if @category = Category.find_by(id: params[:id])

    flash[:danger] = t('admin.category.not_found')
    redirect_to admin_categories_path
  end

  def list_partners
    @partners = Partner.all
  end
end
