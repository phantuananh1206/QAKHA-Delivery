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
      flash[:success] = 'Create user success'
      redirect_to admin_users_path
    else
      flash.now[:danger] = 'Create user failed'
      render :new
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      flash[:success] = 'Update user success'
      redirect_to admin_users_path
    else
      flash.now[:danger] = 'Update user failed'
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = 'Delete user success'
    else
      flash[:danger] = 'Delete user failed'
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

    flash[:danger] = 'user not found'
    redirect_to admin_users_path
  end

  def update_status_user
    @user.send("#{params[:role]}!")
    flash[:success] = "Update status #{params[:role]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
  ensure
    redirect_to admin_users_path
  end
end
