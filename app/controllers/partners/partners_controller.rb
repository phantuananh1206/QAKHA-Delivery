class Partners::PartnersController < ApplicationController
  layout "layouts/partner"
  before_action :check_sign_in

  def index
    @partner = current_partner
  end

  def show
    @partner = current_partner
  end

  def edit;  end

  def update
    if current_partner.update(partner_params)
      flash[:success] = t('admin.partner.update_success')
      redirect_to partners_partner_path
    else
      flash.now[:danger] = t('admin.partner.update_failed')
      render :edit
    end
  end

  def edit_password
    @partner = current_partner
  end

  def update_password
    @partner = current_partner
    if @partner.valid_password? params[:partner][:password_current]
      if @partner.update partner_params
        flash[:success] = t('partner.edit_pw_success')
        redirect_to partners_partner_path current_partner.id
      else
        flash.now[:danger] = t('partner.edit_pw_failed')
        render :edit_password
      end
    else
      flash.now[:danger] = t('partner.old_pw_incorrect')
      render :edit_password
    end
  end

  def update_status
    current_partner.send("#{params[:status]}!")
    if Time.zone.now.strftime('%H:%M') >= current_partner.time_open.strftime('%H:%M') && Time.zone.now.strftime('%H:%M') <= current_partner.time_close.strftime('%H:%M')
      flash[:success] = t('partner.close_store', status: "#{params[:status]}")
    elsif Time.zone.now.strftime('%H:%M') >= current_partner.time_close.strftime('%H:%M') && current_partner.open?
      flash[:danger] = t('partner.close_fail',  status: "#{params[:status]}")
    end
  rescue StandardError
    flash[:danger] = t('partner.close_fail', status: "#{params[:status]}")
  ensure
    redirect_to partners_partners_path
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :address, :phone_number,
                                    :email, :password, :password_confirmation,
                                    :time_open, :time_close, :image,
                                    :city_id, :type_id)
  end
end
