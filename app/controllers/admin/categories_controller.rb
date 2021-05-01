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
      flash[:success] = 'Create category success'
      redirect_to admin_categories_path
    else
      flash.now[:danger] = 'Create category failed'
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Update category success'
      redirect_to admin_categories_path
    else
      flash.now[:danger] = 'Update category failed'
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Delete category success'
    else
      flash[:danger] = 'Delete category failed'
    end
    redirect_to admin_categories_path
  end

  def export
    @categories = Category.order(:name)
    respond_to do |format|
	    format.xls { send_data @categories.to_xls }
	  end
  end

  private

  def category_params
    params.require(:category).permit(:name, :partner_id)
  end

  def load_category
    return if @category = Category.find_by(id: params[:id])

    flash[:danger] = 'Category not found'
    redirect_to admin_categories_path
  end

  def list_partners
    @partners = Partner.all
  end
end
