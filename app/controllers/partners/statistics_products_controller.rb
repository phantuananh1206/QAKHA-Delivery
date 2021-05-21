class Partners::StatisticsProductsController < Partners::PartnersController
  def statistics
    @orders = current_partner.orders._completed_order(params[:delivery_time]["statistics(1i)"].to_i)
    if @orders.present?
      $orders = @orders
    end
    respond_to do |format|
      format.js
      format.html
    end
  rescue StandardError
    render :statistics
  end

  def statistics_by_month
    respond_to do |format|
      format.js
      format.html
     end
  end

  def statistics_by_quarter
    respond_to do |format|
      format.js
      format.html
     end
  end

  def statistics_by_year
    respond_to do |format|
      format.js
      format.html
     end
  end
end
