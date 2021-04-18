module Admin::BaseHelper
  def log_in(admin)
    session[:admin_id] = admin.id
  end

  def current_admin
    @current_admin ||= User.find_by(id: session[:admin_id])
  end

  def logged_in?
    current_admin.present?
  end

  def check_admin
    redirect_to root_path unless user_admin?
  end

  def user_admin?
    current_admin.admin?
  end

  def log_out
    session.delete(:admin_id)
    @current_admin = nil
  end
end
