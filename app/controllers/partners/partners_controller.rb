class Partners::PartnersController < ApplicationController
  layout "layouts/partner"
  before_action :check_sign_in

  def index
    @partner = current_partner
  end

  def update_status
    current_partner.send("#{params[:status]}!")
    flash[:success] = t('partner.close_store', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('partner.close_fail', status: "#{params[:status]}")
  ensure
    redirect_to partners_partners_path
  end
end
