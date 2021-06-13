class User < ApplicationRecord
  include AASM
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze

  mount_uploader :image, ImageUploader

  has_many :orders, dependent: :restrict_with_error
  has_many :feedbacks, dependent: :restrict_with_error
  has_many :addresses, dependent: :restrict_with_error

  enum role: { admin: 0, member: 1, locked: 2 }

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: true }
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: { case_sensitive: true }
  validates :password, allow_nil: true,
            length: {minimum: Settings.validation.password_min}
  validates :coins, allow_nil: true,
            numericality: { greater_than_or_equal_to: Settings.validation.number.zero }
  validate

  aasm column: :role, enum: true do
    state :member, initial: true
    state :admin, :locked

    event :lock do
      transitions from: :member, to: :locked
    end

    event :unlock do
      transitions from: :locked, to: :member
    end
  end

  before_save :downcase_email
  after_commit :send_pending_devise_notifications

  scope :_role_admin, -> { where(role: :admin)}
  scope :_not_role_locked, ->{where.not(role: :locked)}

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
    self.update_columns(reset_password_sent_at: Time.now )
  end

  def password_token_valid?
    (self.reset_password_sent_at + 10.minutes) > Time.now
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save
  end

  def save_image!(image)
    self.update_columns(image: image)
  end

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  def activated
    self.update_columns(confirmed_at: Time.now)
  end

  def send_confirmation_instructions
    self.update_columns(confirmation_token: generate_token, confirmation_sent_at: Time.now)
    super()
  end

  protected

  def send_devise_notification(notification, *args)
    if new_record? || changed?
      pending_devise_notifications << [notification, args]
    else
      render_and_send_devise_message(notification, *args)
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def generate_token
    SecureRandom.base64(6)
  end

  def send_pending_devise_notifications
    pending_devise_notifications.each do |notification, args|
      render_and_send_devise_message(notification, *args)
    end
    pending_devise_notifications.clear
  end

  def pending_devise_notifications
    @pending_devise_notifications ||= []
  end

  def render_and_send_devise_message(notification, *args)
    message = devise_mailer.send(notification, self, *args).deliver_later
  end
end
