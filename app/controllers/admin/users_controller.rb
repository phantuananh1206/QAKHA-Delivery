class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: %i(update edit destroy update_status)
  before_action :load_user_address, only: :show
  before_action :load_address, only: %i(edit_address update_address delete_address)

  def index
    @search = User.search(params[:q])
    @users = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('admin.user.create_success')
      redirect_to admin_users_path
    else
      flash.now[:danger] = t('admin.user.create_failed')
      render :new
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      flash[:success] = t('admin.user.update_success')
      redirect_to admin_users_path
    else
      flash.now[:danger] = t('admin.user.update_failed')
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('admin.user.delete_success')
    else
      flash[:danger] = t('admin.user.delete_failed')
    end
    redirect_to admin_users_path
  end

  def show
    @addresses = $user.addresses.page(params[:page]).per(5)
  end

  def new_address
    @address = $user.addresses.new
  end

  def create_address
    @address = $user.addresses.new(address_params)
    if @address.save
      flash[:success] = t('admin.address.create_success')
      redirect_to admin_user_path($user)
    else
      flash.now[:danger] = t('admin.address.create_failed')
      render :new_address
    end
  end

  def update_address
    if @address.update(address_params)
      flash[:success] = t('admin.address.update_success')
      redirect_to admin_user_path($user)
    else
      flash.now[:danger] = t('admin.address.update_failed')
      render :edit_address
    end
  end

  def delete_address
    if @address.destroy
      flash[:success] = t('admin.address.delete_success')
    else
      flash[:danger] = t('admin.address.delete_failed')
    end
    redirect_to admin_user_path($user)
  end

  def update_status
    update_status_user
  end

  def export
    @users = User.order(:name)
    if @users.present?
      respond_to do |format|
        format.xls { send_data @users.to_xls }
      end
    else
      flash[:danger] = t('admin.user.empty')
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :coins,
                                 :phone_number, :password, :password_confirmation,
                                 :image)
                         .merge(role: params[:role].to_i)
  end

  def address_params
    params.require(:address).permit(:name, :latitude, :longitude)
  end

  def load_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t('admin.user.not_found')
    redirect_to admin_users_path
  end

  def load_user_address
    return if $user = User.find_by(id: params[:id])

    flash[:danger] = t('admin.user.not_found')
    redirect_to admin_users_path
  end

  def load_address
    return if @address = Address.find_by(id: params[:id])

    flash[:danger] = t('admin.address.not_found')
    redirect_to admin_users_path
  end

  def update_status_user
    @user.send("#{params[:role]}!")
    flash[:success] = t('admin.user.update_status_success', status: "#{params[:role]}")
  rescue StandardError
    flash[:danger] = t('admin.user.update_status_failed')
  ensure
    redirect_to admin_users_path
  end
end
