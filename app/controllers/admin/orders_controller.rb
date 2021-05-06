class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(show update)

  def index
    @search = Order.includes(:user, :driver, :partner).search(params[:q])
    @orders = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def show
    @order_details = @order.order_details.includes(:product)
  end

  def update
    update_status_order
  end

  def export
    @orders = Order._created_at_desc
    respond_to do |format|
	    format.xls { send_data @orders.to_xls }
	  end
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:id])

    flash[:danger] = t('admin.order.not_found')
    redirect_to admin_orders_path
  end

  def update_status_order
    @order.send("#{params[:status]}!")
    flash[:success] = t('admin.order.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.order.update_status_failed')
  ensure
    redirect_to admin_orders_path
  end
end
