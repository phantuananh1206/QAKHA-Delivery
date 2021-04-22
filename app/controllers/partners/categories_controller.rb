class Partners::CategoriesController < ApplicationController
  layout "layouts/partner"
  # before_action :authenticate_partner!
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
      flash[:success] = "Creat new category successful"
      redirect_to partners_categories_path
    else
      flash.now[:danger] = "Fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Update category successful!!"
      redirect_to partners_categories_path
    else
      render :edit
    end
  end

  def destroy
    @list_product_of_cate = @category.products.all
    if @list_product_of_cate.blank?
      @category.destroy
      flash[:success] = "Delete category successful"
      redirect_to partners_categories_path
    else
      flash[:danger] = "Delete category fail. You cannot delete this category.
       If you delete it will lose information about the product of this category."
      redirect_to partners_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def load_category
    @category = current_partner.categories.find_by id: params[:id]
    return if @category

    flash[:info] = "Category is empty"
    redirect_to partners_categories_path
  end
end
