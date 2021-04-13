class Partner < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze

  belongs_to :city
  belongs_to :type

  has_one :image, dependent: :destroy
  mount_uploader :image, ImageUploader

  has_many :vouchers, dependent: :destroy
  has_many :categories, dependent: :destroy

  enum status: { open: 0, close: 1 }

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: true, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.validation.password_min}

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
