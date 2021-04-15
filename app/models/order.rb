class Order < ApplicationRecord
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze

  belongs_to :user
  belongs_to :driver
  belongs_to :voucher, optional: true

  has_one :feedback

  has_many :order_details, dependent: :destroy

  validates :name, presence: true
            length: {maximum: Settings.validation.name_max}
  validates :phone_number, format: {with: VALID_PHONE_REGEX},
            length: {minimum: Settings.validation.phone_min},
            uniqueness: true, allow_nil: true
  validates :address, presence: true
  validates :delivery_time, presence: true
  validates :subtotal, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}
  validates :shipping_fee, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}
end
