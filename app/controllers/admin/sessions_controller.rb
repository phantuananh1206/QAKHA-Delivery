class Admin::SessionsController < ApplicationController
  include Admin::BaseHelper

  def new
    if logged_in?
      redirect_to admin_root_path
    end
  end

  def create
    @admin = User._role_admin.find_by(email: params[:session][:email].downcase)
    if @admin&.authenticatable_salt
      log_in(@admin)
      redirect_to admin_root_path
    else
      flash.now[:danger] = 'You are not an admin, please leave!'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to admin_root_path
  end
end
