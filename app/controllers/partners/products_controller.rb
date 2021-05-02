class Partners::ProductsController < Partners::PartnersController
  before_action :load_product, only: %i(edit update destroy)

  def index
    @search = current_partner.products.includes(:category).search(params[:q])
    @products = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = "Creat new product successful"
      redirect_to partners_products_path
    else
      flash.now[:danger] = "Creat new product fail"
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      # byebug
      flash[:success] = "Update product successful"
      redirect_to partners_products_path
    else
      render :edit
    end
  end

  def destroy
    product_ordering = @product.orders.where(status: "shipping")
    # byebug
    if product_ordering.blank?
      if @product.destroy
        flash[:success] = "Delete product successful"
      else
        flash[:danger] = "You cannot delete this product. If you delete it, it will affect the store's statistics."
      end
    else
      flash[:danger] = "Delete product fail. This products is shipping !!"
    end
    redirect_to partners_products_path
  end

  private

  def product_params
    params.require(:product).permit :name, :price, :description, :category_id, :image
  end

  def load_product
    return if @product = current_partner.products.find_by(id: params[:id])

    flash[:info] = "Product is empty"
    redirect_to partners_products_path
  end
end
