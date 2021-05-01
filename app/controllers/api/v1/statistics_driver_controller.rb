class Api::V1::StatisticsDriverController < Api::V1::ApplicationController
  include Api::V1::DriversHelper

  before_action :load_driver

  def statistics_by_day
    total_cash = 0
    total_coins = 0
    total_paypal = 0
    total_daily_income = 0
    @orders = Order.where(driver_id: @current_driver.id, status: :completed)
                   .where("DATE(delivery_time) = ?", params[:day].to_date)
    @orders.each do |order|
      if order.cash?
        total_cash += order.shipping_fee.to_f
      elsif order.coins?
        total_coins += order.shipping_fee.to_f
      elsif order.paypal?
        total_paypal += order.shipping_fee.to_f
      end
      total_daily_income = total_cash + total_coins + total_paypal
    end
    render json: { total_cash: total_cash, total_coins: total_coins,
                   total_paypal: total_paypal, total_daily_income: total_daily_income }, status: :ok
  end

  def statistics_by_month
    total_cash = 0
    total_coins = 0
    total_paypal = 0
    total_monthly_income = 0
    @orders = Order.where(driver_id: @current_driver.id, status: :completed)
                   .where("MONTH(delivery_time) = ?", params[:month])
    @orders.each do |order|
      if order.cash?
        total_cash += order.shipping_fee.to_f
      elsif order.coins?
        total_coins += order.shipping_fee.to_f
      elsif order.paypal?
        total_paypal += order.shipping_fee.to_f
      end
      total_monthly_income = total_cash + total_coins + total_paypal
    end
    render json: { total_cash: total_cash, total_coins: total_coins,
                   total_paypal: total_paypal, total_monthly_income: total_monthly_income }, status: :ok
  end

  def statistics_by_year
    total_cash = 0
    total_coins = 0
    total_paypal = 0
    total_annual_income = 0
    @orders = Order.where(driver_id: @current_driver.id, status: :completed)
                   .where("YEAR(delivery_time) = ?", params[:year])
    @orders.each do |order|
      if order.cash?
        total_cash += order.shipping_fee.to_f
      elsif order.coins?
        total_coins += order.shipping_fee.to_f
      elsif order.paypal?
        total_paypal += order.shipping_fee.to_f
      end
      total_annual_income = total_cash + total_coins + total_paypal
    end
    render json: { total_cash: total_cash, total_coins: total_coins,
                   total_paypal: total_paypal, total_annual_income: total_annual_income }, status: :ok
  end
end
