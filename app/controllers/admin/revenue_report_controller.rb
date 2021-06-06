class Admin::RevenueReportController < Admin::BaseController
  def revenue; end

  def revenue_by_month
    @orders = Order._order_completed._revenue_month(params[:delivery_time]["report(2i)"].to_i)._revenue_year(params[:delivery_time]["report(1i)"].to_i)
    total = @orders.reduce(0) do |total, order|
      total += (order.total * 10 / 100) + (order.shipping_fee * 10 / 100)
    end
    csv = CSV.generate do |csv|
      csv << ['revenue', 'month', 'year']
      csv << [total, params[:delivery_time]["report(2i)"].to_i, params[:delivery_time]["report(1i)"].to_i]
    end
    respond_to do |format|
      format.xls { send_data(csv, filename: filename_excel(t('admin.file_name.revenue_by_month'), Time.now)) }
    end
  end

  def revenue_by_year
    @orders = Order._completed_order(params[:delivery_time]["report(1i)"].to_i)
    total = @orders.reduce(0) do |total, order|
      total += (order.total * 10 / 100) + (order.shipping_fee * 10 / 100)
    end
    csv = CSV.generate do |csv|
      csv << ['revenue', 'year']
      csv << [total, params[:delivery_time]["report(1i)"].to_i]
    end
    respond_to do |format|
      format.xls { send_data(csv, filename: filename_revenue(t('admin.file_name.revenue_by_year'), Time.now)) }
    end
  end
end
