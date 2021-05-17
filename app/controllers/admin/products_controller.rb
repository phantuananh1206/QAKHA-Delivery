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
      flash[:success] = t('admin.product.create_success')
      redirect_to admin_products_path
    else
      flash.now[:danger] = t('admin.product.create_failed')
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = t('admin.product.update_success')
      redirect_to admin_products_path
    else
      flash.now[:danger] = t('admin.product.update_failed')
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t('admin.product.delete_success')
    else
      flash[:danger] = t('admin.product.delete_failed')
    end
    redirect_to admin_products_path
  end

  def export
    @products = Product.order(:name)
    if @products.present?
      respond_to do |format|
        format.xls { send_data @products.to_xls }
      end
    else
      flash[:danger] = t('admin.product.empty')
      redirect_to admin_products_path
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

    flash[:danger] = t('admin.product.not_found')
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
    flash[:success] = t('admin.product.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.product.update_status_failed')
  ensure
    redirect_to admin_products_path
  end
end
