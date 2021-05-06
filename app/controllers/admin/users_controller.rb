class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: %i(index new create export)

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

  def update_status
    update_status_user
  end

  def export
    @users = User.order(:name)
    respond_to do |format|
	    format.xls { send_data @users.to_xls }
	  end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :coins,
                                 :phone_number, :password, :password_confirmation,
                                 :image)
                         .merge(role: params[:role].to_i)
  end

  def load_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t('admin.user.not_found')
    redirect_to admin_users_path
  end

  def update_status_user
    @user.send("#{params[:role]}!")
    flash[:success] = t('admin.user.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.user.update_status_failed')
  ensure
    redirect_to admin_users_path
  end
end
