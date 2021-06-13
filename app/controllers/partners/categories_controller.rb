class Partners::CategoriesController < Partners::PartnersController
  before_action :check_sign_in
  before_action :load_category, only: %i(edit update destroy)

  def index
    @search = Category.load_category_of_partner(current_partner.id).search(params[:q])
    @categories = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params.merge(partner_id: current_partner.id)
    if @category.save
      flash[:success] = t('admin.category.create_success')
      redirect_to partners_categories_path
    else
      flash.now[:danger] = t('admin.category.create_failed')
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t('admin.category.update_success')
      redirect_to partners_categories_path
    else
      flash.now[:danger] = t('admin.category.update_failed')
      render :edit
    end
  end

  def destroy
    @list_product_of_cate = @category.products.all
    if @list_product_of_cate.blank?
      @category.destroy
      flash[:success] = t('admin.category.delete_success')
      redirect_to partners_categories_path
    else
      flash[:danger] = t('admin.category.delete_failed')
      redirect_to partners_categories_path
    end
  end

  def export
    @categories = current_partner.categories.order(:id)
    if @categories.present?
      respond_to do |format|
        format.xls { send_data(@categories.to_xls, filename: filename_excel(t('admin.file_name.category'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.category.empty')
      redirect_to partners_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = current_partner.categories.find_by id: params[:id]
    return if @category

    flash[:info] = t('admin.category.empty')
    redirect_to partners_categories_path
  end
end
