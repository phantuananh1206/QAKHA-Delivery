class Partners::OrdersController < ApplicationController
  layout "layouts/partner"
    before_action :load_order, only: %i(show update)

  def index
    @search = current_partner.orders.includes(:user, :driver)._created_at_desc.search(params[:q])
    @orders = @search.result._created_at_desc.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def show
    @order_details = @order.order_details
  end

  def update
    update_status_order
  end

  def export
    @orders = current_partner.orders._created_at_desc
    if @orders.present?
      respond_to do |format|
        format.xls { send_data(@orders.to_xls, filename: filename_excel(t('admin.file_name.order'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.order.empty')
      redirect_to partners_orders_path
    end
  end

  private

  def load_order
    return if @order = Order.find_by(id: params[:id])

    flash[:danger] = t('admin.order.not_found')
    redirect_to partners_orders_path
  end

  def update_status_order
    @order.send("#{params[:status]}!")
    flash[:success] = t('admin.order.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.order.update_status_failed')
  ensure
    redirect_to partners_orders_path
  end
end
