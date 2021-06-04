class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_authenticity_token

  before_action :load_partner_authentication, only: [:create]

  def new
    if partner_signed_in?
      redirect_to partners_partners_path
    end
  end

  def create
    if @partner.present?
      if @partner.valid_password? params[:partner][:password]
        if @partner.open? || @partner.close?
          if sign_in @partner
            flash[:success] = t('partner.session.sign_in_success')
            redirect_to partners_partners_path
          end
        else
          flash[:danger] =  t('partner.session.acc_not_activate')
          render :new
        end
      else
        flash[:danger] = t('partner.session.sign_in_fail')
        render :new
      end
    else
      flash[:danger] = t('partner.session.please_log_in')
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
      flash.now[:danger] = t('partner.session.authen')
      render :new
    end
  end
end
