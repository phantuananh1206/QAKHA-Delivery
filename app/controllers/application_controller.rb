class ApplicationController < ActionController::Base
  include ApplicationHelper
  respond_to :json

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
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
end
