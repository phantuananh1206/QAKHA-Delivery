class ApplicationController < ActionController::Base
  respond_to :json

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
