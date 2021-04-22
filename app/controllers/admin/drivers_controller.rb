class Admin::DriversController < Admin::BaseController
  before_action :load_driver, except: %i(index new create export)

  def index
    @search = Driver.search(params[:q])
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
      flash[:success] = 'Create driver success'
      redirect_to admin_drivers_path
    else
      flash.now[:danger] = 'Create driver failed'
      render :new
    end
  end

  def update
    if params[:driver][:password].blank? && params[:driver][:password_confirmation].blank?
      params[:driver].delete(:password)
      params[:driver].delete(:password_confirmation)
    end
    if @driver.update(driver_params)
      flash[:success] = 'Update driver success'
      redirect_to admin_drivers_path
    else
      flash.now[:danger] = 'Update driver failed'
      render :edit
    end
  end

  def destroy
    if @driver.destroy
      flash[:success] = 'Delete driver success'
    else
      flash[:danger] = 'Delete driver failed'
    end
    redirect_to admin_drivers_path
  end

  def update_status
    update_status_driver
  end

  def export
    @drivers = Driver.order(:name)
    respond_to do |format|
	    format.xls { send_data @drivers.to_xls }
	  end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :email, :address, :id_card,
                                   :phone_number, :password, :password_confirmation,
                                   :license_plate, :image)
  end

  def load_driver
    return if @driver = Driver.find_by(id: params[:id])

    flash[:danger] = 'Driver not found'
    redirect_to admin_drivers_path
  end

  def update_status_driver
    @driver.send("#{params[:status]}!")
    flash[:success] = "Update status #{params[:status]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
  ensure
    redirect_to admin_drivers_path
  end
end
