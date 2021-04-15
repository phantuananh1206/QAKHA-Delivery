class Driver < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  VALID_PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/.freeze
  VALID_ID_CARD_REGEX = /\A\d[0-9]{9}\z/.freeze

  has_one :image, dependent: :destroy
  mount_uploader :image, ImageUploader

  has_one :feedback

  has_many :orders, dependent: :destroy

  enum status: { not_activated: 0, offline: 1, online: 2, locked: 3}

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email_max},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :id_card, presence: true,
            length: {minimum: Settings.validation.id_card_min},
            format: {with: VALID_ID_CARD_REGEX}, uniqueness: true
  validates :phone_number, format: {width: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: true, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.validation.password_min}
  validates :license_plate, presence: true, uniqueness: true
end
