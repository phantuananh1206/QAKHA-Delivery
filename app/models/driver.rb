class Driver < ApplicationRecord
  include AASM
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze
  # VALID_ID_CARD_REGEX = /^[0-9]{9,}$.freeze

  mount_uploader :image, ImageUploader

  has_many :feedbacks, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error

  enum status: { not_activated: 0, offline: 1, online: 2, shipping: 3, locked: 4}

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: true }
  validates :id_card, presence: true,
            length: {minimum: Settings.validation.id_card_min},
            uniqueness: { case_sensitive: true }
            # format: {with: VALID_ID_CARD_REGEX}
  validates :phone_number, format: { with: VALID_PHONE_REGEX },
            length: {minimum: Settings.validation.phone_min},
            uniqueness: { case_sensitive: true }, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.validation.password_min},
            allow_nil: true
  validates :license_plate, presence: true, uniqueness: { case_sensitive: true }
  validates :coins, allow_nil: true,
            numericality: { greater_than_or_equal_to: Settings.validation.number.zero }

  aasm column: :status, enum: true do
    state :not_activated, initial: true
    state :offline, :online, :shipping, :locked

    event :active do
      transitions from: :not_activated, to: :offline
    end

    event :online do
      transitions from: :offline, to: :online
    end

    event :offline do
      transitions from: :online, to: :offline
    end

    event :ship do
      transitions from: :online, to: :shipping
    end

    event :delivered do
      transitions from: :shipping, to: :online
    end

    event :lock do
      transitions from: [:offline, :online], to: :locked
    end
  end

  before_save :downcase_email

  scope :by_ids, ->(ids) { where(id: ids) }
  scope :_can_ship, -> { where(status: :online) }

  def save_image!(image)
    self.update_columns(image: image)
  end

  def avg_point_feedback_driver
    if feedbacks.present?
      feedbacks.average(:point).round(1).to_f
    else
      0.0
    end
  end

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |driver|
        csv << driver.attributes.values_at(*column_names)
      end
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
