class SessionsController < ApplicationController
  include SessionsHelper
  before_action :load_partner_authentication, only: [:create]

  def new; end

  def create
    if @partner.present?
      if @partner.valid_password? params[:partner][:password]
        if sign_in @partner
          flash[:success] = "Sign in successfuly"
          redirect_to partners_partners_path
        end
      else
        flash[:danger] = "Sign in fail"
        render :new
      end
    else
      flash[:danger] = "Please sign up"
    end
  end

  def destroy
    sign_out @partner
    redirect_to root_path
  end

  private

  def load_partner_authentication
    @partner = Partner.find_by_email params[:partner][:email]
    if @partner.present?
      return @partner
    else
      flash.now[:danger] = " Please check your account !!"
      render :new
    end
  end
end
