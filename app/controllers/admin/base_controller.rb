class Admin::BaseController < ApplicationController
  include Admin::BaseHelper

  before_action :logged_in_admin

  layout 'layouts/admin'

  def home; end

  private

  def logged_in_admin
    return if logged_in?

    flash[:danger] = t('admin.session.please_log_in')
    redirect_to admin_sign_in_path
  end
end
