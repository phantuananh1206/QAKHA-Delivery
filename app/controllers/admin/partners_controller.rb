class Admin::PartnersController < Admin::BaseController
  before_action :load_partner, except: %i(index new create)
  before_action :list_city, :list_type, except: %i(index destroy)

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
      flash[:success] = 'Create partner success'
      redirect_to admin_partners_path
    else
      flash.now[:danger] = 'Create partner failed'
      render :new
    end
  end

  def update
    if params[:partner][:password].blank? && params[:partner][:password_confirmation].blank?
      params[:partner].delete(:password)
      params[:partner].delete(:password_confirmation)
    end
    if @partner.update(partner_params)
      flash[:success] = 'Update partner success'
      redirect_to admin_partners_path
    else
      flash.now[:danger] = 'Update partner failed'
      render :edit
    end
  end

  def destroy
    if @partner.destroy
      flash[:success] = 'Delete partner success'
    else
      flash[:danger] = 'Delete partner failed'
    end
    redirect_to admin_partners_path
  end

  def update_status
    update_status_partner
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

    flash[:danger] = 'Partner not found'
    redirect_to admin_root_path
  end

  def update_status_partner
    @partner.send("#{params[:status]}!")
    flash[:success] = "Update status #{params[:status]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
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
