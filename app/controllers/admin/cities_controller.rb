class Admin::CitiesController < Admin::BaseController
  before_action :load_city, except: %i(index new create export)

  def index
    @search = City.search(params[:q])
    @cities = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save
      flash[:success] = t('admin.city.create_success')
      redirect_to admin_cities_path
    else
      flash.now[:danger] = t('admin.city.create_failed')
      render :new
    end
  end

  def update
    if @city.update(city_params)
      flash[:success] = t('admin.city.update_success')
      redirect_to admin_cities_path
    else
      flash.now[:danger] = t('admin.city.update_failed')
      render :edit
    end
  end

  def destroy
    if @city.destroy
      flash[:success] = t('admin.city.delete_success')
    else
      flash[:danger] = t('admin.city.delete_failed')
    end
    redirect_to admin_cities_path
  end

  def export
    @cities = City.order(:name)
    respond_to do |format|
	    format.xls { send_data @cities.to_xls }
	  end
  end

  private

  def load_city
    return if @city = City.find_by(id: params[:id])

    flash[:danger] = t('admin.city.not_found')
    redirect_to admin_cities_path
  end

  def city_params
    params.require(:city).permit(:name)
  end
end
