module SessionsHelper
  def resource_name
    :partner
  end

  def resource
    @resource ||= Partner.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:partner]
  end

  def check_sign_in
    return if partner_signed_in?
    byebug
    flash[:danger] = "Please sign-in"
    redirect_to partner_session_path
  end
end
