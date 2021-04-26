class ApplicationController < ActionController::Base
  include ApplicationHelper
  respond_to :json

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :load_partners, :load_voucher
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
      if Time.zone.now.strftime('%H:%M') >= partner.time_open.strftime('%H:%M') && Time.zone.now.strftime('%H:%M') <= partner.time_close.strftime('%H:%M') && partner.close?
        partner.update_columns(status: :open)
      elsif Time.zone.now.strftime('%H:%M') >= partner.time_close.strftime('%H:%M') && partner.open?
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
end
