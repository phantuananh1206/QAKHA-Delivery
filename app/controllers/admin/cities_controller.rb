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
      flash[:success] = 'Create city success'
      redirect_to admin_cities_path
    else
      flash.now[:danger] = 'Create city failed'
      render :new
    end
  end

  def update
    if @city.update(city_params)
      flash[:success] = 'Update city success'
      redirect_to admin_cities_path
    else
      flash.now[:danger] = 'Update city failed'
      render :edit
    end
  end

  def destroy
    if @city.destroy
      flash[:success] = 'Delete city success'
    else
      flash[:danger] = 'Delete city failed'
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

    flash[:danger] = 'City not found'
    redirect_to admin_cities_path
  end

  def city_params
    params.require(:city).permit(:name)
  end
end
