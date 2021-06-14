class Admin::AddressesController < Admin::BaseController
  before_action :load_address, except: %i(index new create export)
  before_action :list_users, except: %i(index destroy export)

  def index
    @search = Address.includes(:user)._created_at_desc.search(params[:q])
    @addresses = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:success] = t('admin.address.create_success')
      redirect_to admin_addresses_path
    else
      flash.now[:danger] = t('admin.address.create_failed')
      render :new
    end
  end

  def update
    if @address.update(address_params)
      flash[:success] = t('admin.address.update_success')
      redirect_to admin_addresses_path
    else
      flash.now[:danger] = t('admin.address.update_failed')
      render :edit
    end
  end

  def destroy
    if @address.destroy
      flash[:success] = t('admin.address.delete_success')
    else
      flash[:danger] = t('admin.address.delete_failed')
    end
    redirect_to admin_addresses_path
  end

  def export
    @addresses = Address.order(:name)
    if @addresses.present?
      respond_to do |format|
        format.xls { send_data(@addresses.to_xls, filename: filename_excel(t('admin.file_name.address'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.address.empty')
      redirect_to admin_addresses_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :latitude, :longitude, :user_id)
  end

  def load_address
    return if @address = Address.find_by(id: params[:id])

    flash[:danger] = t('admin.address.not_found')
    redirect_to admin_addresses_path
  end

  def list_users
    @users = User.all
  end
end
