class Admin::PartnersController < Admin::BaseController
  before_action :load_partner, except: %i(index new create export)
  before_action :list_city, :list_type, except: %i(index destroy export)

  def index
    @search = Partner.search(params[:q])
    @partners = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      flash[:success] = t('admin.partner.create_success')
      redirect_to admin_partners_path
    else
      flash.now[:danger] = t('admin.partner.create_failed')
      render :new
    end
  end

  def update
    if params[:partner][:password].blank? && params[:partner][:password_confirmation].blank?
      params[:partner].delete(:password)
      params[:partner].delete(:password_confirmation)
    end
    if @partner.update(partner_params)
      flash[:success] = t('admin.partner.update_success')
      redirect_to admin_partners_path
    else
      flash.now[:danger] = t('admin.partner.update_failed')
      render :edit
    end
  end

  def destroy
    if @partner.destroy
      flash[:success] = t('admin.partner.delete_success')
    else
      flash[:danger] = t('admin.partner.delete_failed')
    end
    redirect_to admin_partners_path
  end

  def update_status
    update_status_partner
  end

  def export
    @partners = Partner.order(:name)
    respond_to do |format|
	    format.xls { send_data @partners.to_xls }
	  end
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :address, :phone_number,
                                    :email, :password, :password_confirmation,
                                    :time_open, :time_close, :image,
                                    :city_id, :type_id)
  end

  def load_partner
    return if @partner = Partner.find_by(id: params[:id])

    flash[:danger] = t('admin.partner.not_found')
    redirect_to admin_partners_path
  end

  def update_status_partner
    @partner.send("#{params[:status]}!")
    flash[:success] = t('admin.partner.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.partner.update_status_failed')
  ensure
    redirect_to admin_partners_path
  end

  def list_city
    @cities = City.all
  end

  def list_type
    @types = Type.all
  end
end
