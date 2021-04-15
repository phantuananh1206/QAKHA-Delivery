class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze

  has_one :image, dependent: :destroy
  mount_uploader :image, ImageUploader

  has_many :orders, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum role: {admin: 0, member: 1, block: 2}

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: true }
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: { case_sensitive: true }, allow_nil: true
  validates :password, allow_nil: true,
            length: {minimum: Settings.validation.password_min}
  validates :coins, allow_nil: true,
            numericality: { greater_than_or_equal_to: Settings.validation.number.zero }

  before_save :downcase_email

  def self.from_omniauth(auth)
    user_with_provider = find_by(provider: auth.provider, uid: auth.uid)
    return user_with_provider if user_with_provider

    user = find_or_initialize_by(email: auth.info.email)
    if user.new_record?
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.skip_confirmation!
    end
    user.uid = auth.uid
    user.provider = auth.provider
    user.image = auth.info.image
    user.save
    user
  end

  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def generate_password_token!
    # self.reset_password_token = generate_token
    self.update_columns(reset_password_token: generate_token)
    self.update_columns(reset_password_sent_at: Time.now.utc )
  end

  def password_token_valid?
    (self.reset_password_sent_at + 10.minutes) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save
  end

  def save_image!(image)
    self.update_columns(image: image)
  end

  private

  def downcase_email
    email.downcase!
  end

  def generate_token
    SecureRandom.base36(5)
  end
end
