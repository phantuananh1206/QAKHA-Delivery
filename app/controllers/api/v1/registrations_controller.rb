class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    if params[:type_user].present?
      case params[:type_user].to_i
      when 1
        user = User.new user_params
        create_user user
      when 2
        driver = Driver.new driver_params
        save_driver driver
      when 3
        if check_location_partner
          partner = Partner.new partner_params
          create_user partner
        else
          render json: {message: "Please choose location of the food store!!"}, status: :not_found
        end
      else
        render json: {message: "type_user invalid"}, status: :bad_request
      end
    end
  end

  def create_user user
    if check_email_exist(user)
      render json: {message: "Email is already exists in database"}, status: :bad_request
    else
      if check_phonenumber_exist(user)
        render json: {message: "Phone Number is already exists in database"}, status: :bad_request
      else
        save_user user
      end
    end
  end

  def save_user user
    if user.save
      user.save_image!(params[:image])
      render json: true, status: :created
    else
      warden.custom_failure!
      render json: {message: user.errors.full_messages}, status: :bad_request
    end
  end

  def check_email_exits
    user = User.new user_params
    if params[:email].present?
      if check_email_exist(user)
        render json: false, status: :bad_request
      else
        render json: true, status: :ok
      end
    else
      render json: false, status: :not_found
    end
  end

  def check_phone_number_exits
    user = User.new user_params
    if check_phonenumber_exist(user)
      render json: false, status: :bad_request
    else
      render json: true, status: :ok
    end
  end

  def check_id_card_driver
    driver = Driver.new driver_params
    if check_idcard_driver(driver)
      render json: false, status: :bad_request
    else
      render json: true, status: :ok
    end
  end

  def check_license_plate_driver
    driver = Driver.new driver_params
    if check_licenseplate_driver(driver)
      render json: false, status: :bad_request
    else
      render json: true, status: :ok
    end
  end

  def save_driver driver
    if check_idcard_driver(driver)
      render json: {message: "ID CARD is already exists in database"}, status: :bad_request
    else
      if check_licenseplate_driver(driver)
        render json: {message: "LICENSE PLATE is already exists in database"}, status: :bad_request
      else
        create_user driver
      end
    end
  end

  private

  def check_email_exist user
    user = User.find_by_email params[:email]
    return true if user

    user = Driver.find_by_email params[:email]
    return true if user

    user = Partner.find_by_email params[:email]
    return true if user
  end

  def check_phonenumber_exist user
    user = User.find_by_phone_number params[:phone_number]
    return true if user

    user = Driver.find_by_phone_number params[:phone_number]
    return true if user

    user = Partner.find_by_phone_number params[:phone_number]
    return true if user
  end

  def check_location_partner
    return true if params[:latitude].present? && params[:longitude].present?
  end

  def check_idcard_driver driver
    driver = Driver.find_by_id_card params[:id_card]
    return true if driver
  end

  def check_licenseplate_driver driver
    driver = Driver.find_by_license_plate params[:license_plate]
    return true if driver
  end

  def user_params
    params.permit :email, :password, :password_confirmation, :name, :phone_number, :image
  end

  def driver_params
    params.permit :name, :email, :id_card, :phone_number, :address,
                  :password, :license_plate, :image
  end

  def partner_params
    params.permit :name, :email, :address, :phone_number, :password,
                  :latitude, :longitude, :time_open, :time_close, :image, :city_id, :type_id
  end
end
