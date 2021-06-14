class Admin::DriversController < Admin::BaseController
  before_action :load_driver, except: %i(index new create export)

  def index
    @search = Driver._created_at_desc.search(params[:q])
    @drivers = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:success] = t('admin.driver.create_success')
      redirect_to admin_drivers_path
    else
      flash.now[:danger] = t('admin.driver.create_failed')
      render :new
    end
  end

  def update
    if params[:driver][:password].blank? && params[:driver][:password_confirmation].blank?
      params[:driver].delete(:password)
      params[:driver].delete(:password_confirmation)
    end
    if @driver.update(driver_params)
      flash[:success] = t('admin.driver.update_success')
      redirect_to admin_drivers_path
    else
      flash.now[:danger] = t('admin.driver.update_failed')
      render :edit
    end
  end

  def destroy
    if @driver.destroy
      flash[:success] = t('admin.driver.delete_success')
    else
      flash[:danger] = t('admin.driver.delete_failed')
    end
    redirect_to admin_drivers_path
  end

  def update_status
    update_status_driver
  end

  def export
    @drivers = Driver.order(:name)
    if @drivers.present?
      respond_to do |format|
        format.xls { send_data(@drivers.to_xls, filename: filename_excel(t('admin.file_name.driver'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.driver.empty')
      redirect_to admin_drivers_path
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :email, :address, :id_card, :coins,
                                   :phone_number, :password, :password_confirmation,
                                   :license_plate, :image)
  end

  def load_driver
    return if @driver = Driver.find_by(id: params[:id])

    flash[:danger] = t('admin.driver.not_found')
    redirect_to admin_drivers_path
  end

  def update_status_driver
    @driver.send("#{params[:status]}!")
    flash[:success] = t('admin.driver.update_status_success', status: "#{params[:status]}")
  rescue StandardError
  flash[:danger] = t('admin.driver.update_status_failed')
  ensure
    redirect_to admin_drivers_path
  end
end
