class Order < ApplicationRecord
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze

  belongs_to :user
  belongs_to :driver
  belongs_to :voucher, optional: true

  has_one :feedback

  has_many :order_details, dependent: :restrict_with_error

  with_options presence: true do
    validates :name,
              length: {maximum: Settings.validation.name_max}
    validates :phone_number, format: {with: VALID_PHONE_REGEX},
              length: {minimum: Settings.validation.phone_min}
    validates :address
    validates :delivery_time
    validates :subtotal,
              numericality: {greater_than: Settings.validation.number.zero}
    validates :shipping_fee,
              numericality: {greater_than: Settings.validation.number.zero}
    validates :total,
              numericality: {greater_than: Settings.validation.number.zero}
  end

  after_create :update_quantity_sold_of_product

  def update_quantity_sold_of_product
    order_details.each do |order_detail|
      order_detail.update_quantity_product
    end
  end
end
