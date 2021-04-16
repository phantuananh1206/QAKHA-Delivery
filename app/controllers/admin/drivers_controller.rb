class Admin::DriversController < ApplicationController
  before_action :load_driver

  def statistics_by_day
    @orders = @driver.completed_order(params[:day])
    @total_daily_income = 0
    @orders.each do |order|
      @total_daily_income += order.shipping_fee
    end
    @total_daily_income
  end

  private

  def load_driver
    return if @driver = Driver.find_by(id: params[:id])

    flash[:danger] = 'Driver not found'
  end
end
