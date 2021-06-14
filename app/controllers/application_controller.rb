class ApplicationController < ActionController::Base
  include ApplicationHelper
  respond_to :json

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :load_partners, :load_voucher
  before_action :auto_clear_cart
  include SessionsHelper

  private

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_partners
    @partners = Partner.all
    @partners.each do |partner|
      if Time.zone.now.strftime('%H:%M') >= partner.time_close.strftime('%H:%M') && partner.open?
        partner.update_columns(status: :close)
      end
    end
  end

  def load_voucher
    @vouchers = Voucher.all
    @vouchers.each do |voucher|
      if Time.zone.now >= voucher.expiry_date && voucher.effective?
        voucher.update_columns(status: :void)
      elsif Time.zone.now < voucher.expiry_date && voucher.void?
        voucher.update_columns(status: :effective)
      end
    end
  end

  def auto_clear_cart
    HardWorker.perform_at(Time.now)
  end

  def filename_excel(filename, export_date)
    "#{filename}_#{format_date_export_excel(export_date)}.xls"
  end

  def format_date_export_excel(date)
    date.strftime('%d%m%Y')
  end

  def filename_revenue(filename, export_date)
    "#{filename}_#{format_year_export_excel(export_date)}.xls"
  end

  def format_year_export_excel(date)
    date.strftime('%Y')
  end
end
