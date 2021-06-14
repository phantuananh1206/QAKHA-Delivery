class Partners::ProductsController < Partners::PartnersController
  before_action :load_product, only: %i(edit update destroy update_status)

  def index
    @search = current_partner.products.includes(:category)._created_at_desc.search(params[:q])
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
      flash[:success] = t('admin.product.create_success')
      redirect_to partners_products_path
    else
      flash.now[:danger] = t('admin.product.create_failed')
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t('admin.product.update_success')
      redirect_to partners_products_path
    else
      flash.now[:danger] = t('admin.product.update_failed')
      render :edit
    end
  end

  def destroy
    product_ordering = @product.orders.where(status: "shipping")
    if product_ordering.blank?
      if @product.destroy
        flash[:success] = t('admin.product.delete_success')
      else
        flash[:danger] = t('partner.product.delete_f')
      end
    else
      flash[:danger] = t('admin.product.delete_failed')
    end
    redirect_to partners_products_path
  end

  def update_status
    @product.send("#{params[:status]}!")
    flash[:success] = t('admin.product.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.product.update_status_failed')
  ensure
    redirect_to partners_products_path
  end

  def export
    @products = current_partner.products.order(:name)
    if @products.present?
      respond_to do |format|
        format.xls { send_data(@products.to_xls, filename: filename_excel(t('admin.file_name.product'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.product.empty')
      redirect_to partners_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :price, :description, :category_id, :image
  end

  def load_product
    return if @product = current_partner.products.find_by(id: params[:id])

    flash[:info] = t('admin.product.not_found')
    redirect_to partners_products_path
  end
end
