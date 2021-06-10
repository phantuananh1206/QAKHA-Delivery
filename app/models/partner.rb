class Partner < ApplicationRecord
  include AASM
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze

  belongs_to :city
  belongs_to :type

  mount_uploader :image, ImageUploader

  has_many :vouchers, dependent: :restrict_with_error
  has_many :categories, dependent: :restrict_with_error
  has_many :feedbacks, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error
  has_many :products, through: :categories

  enum status: { not_activated: 0, open: 1, close: 2, locked: 3 }

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: true }
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: { case_sensitive: true }, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.validation.password_min},
            allow_nil: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :time_open, presence: true
  validates :time_close, presence: true
  validate :time_close_valid, on: %i(create update)

  aasm column: :status, enum: true do
    state :not_activated, initial: true
    state :open, :close, :locked

    event :active do
      transitions from: :not_activated, to: :close
    end

    event :open do
      transitions from: :close, to: :open
    end

    event :close do
      transitions from: :open, to: :close
    end

    event :lock do
      transitions from: [:open, :close], to: :locked
    end

    event :unlock do
      transitions from: :locked, to: :close
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save :downcase_email
  after_save :clear_cache_partners
  after_destroy :clear_cache_partners

  scope :_partner_valid, -> { where.not(status: :not_activated).where.not(status: :locked) }
  scope :_partner_open, -> { where(status: :open) }

  def save_image!(image)
    self.update_columns(image: image)
  end

  before_save :downcase_email

  def as_json(options = {})
    super.merge(time_open: time_open.strftime('%H:%M:%S'),
                time_close: time_close.strftime('%H:%M:%S'))
  end

  def avg_point_feedback_partner
    if feedbacks.present?
      feedbacks.average(:point).round(1).to_f
    else
      0.0
    end
  end

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |partner|
        csv << partner.attributes.values_at(*column_names)
      end
    end
  end

  def time_close_valid
    return if time_close > time_open

    errors.add :time_close, 'must be greater than Time open'
  end

  def activated
    self.update_columns(confirmed_at: Time.now)
  end

  def number_of_reviews
    if feedbacks.present?
      feedbacks.count(:partner_id).to_i
    else
      0
    end
  end

  def clear_cache_partners
    $redis.del 'partners'
  end

  def send_confirmation_instructions
    super()

    self.update_columns(confirmation_sent_at: Time.now)
  end
  
  private

  def downcase_email
    email.downcase!
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
