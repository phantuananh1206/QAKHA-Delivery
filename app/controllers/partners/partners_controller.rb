class Partners::PartnersController < ApplicationController
  layout "layouts/partner"
  before_action :check_sign_in

  def index
    @partner = current_partner
  end

  def update_status
    current_partner.send("#{params[:status]}!")
    flash[:success] = "Update status #{params[:status]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
  ensure
    redirect_to partners_partners_path
  end


end
