class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze

  has_many_attached :images
  has_many :orders, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  enum role: {admin: 0, member: 1, block: 2}

  # validates :name, presence: true,
  #           length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: true, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.validation.password_min}

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

  private

  def downcase_email
    email.downcase!
  end
end
