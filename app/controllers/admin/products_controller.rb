class Admin::ProductsController < Admin::BaseController
  before_action :load_product, except: %i(index new create export)
  before_action :list_partners, :list_categories, except: %i(index destroy export)

  def index
    @search = Product.includes(category: [:partner]).search(params[:q])
    @p = Partner.search(params[:q])
    @products = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Create product success'
      redirect_to admin_products_path
    else
      flash.now[:danger] = 'Create product failed'
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Update product success'
      redirect_to admin_products_path
    else
      flash.now[:danger] = 'Update product failed'
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = 'Delete product success'
    else
      flash[:danger] = 'Delete product failed'
    end
    redirect_to admin_products_path
  end

  def export
    @products = Product.order(:name)
    respond_to do |format|
	    format.xls { send_data @products.to_xls }
	  end
  end

  def update_status
    update_status_product
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description,
                                    :category_id, :image)
  end

  def load_product
    return if @product = Product.find_by(id: params[:id])

    flash[:danger] = 'product not found'
    redirect_to admin_products_path
  end

  def list_categories
    @categories = Category.all
  end

  def list_partners
    @partners = Partner.all
  end

  def update_status_product
    @product.send("#{params[:status]}!")
    flash[:success] = "Update status #{params[:status]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
  ensure
    redirect_to admin_products_path
  end
end
