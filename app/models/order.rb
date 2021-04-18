class Order < ApplicationRecord
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze

  belongs_to :user
  belongs_to :driver
  belongs_to :voucher, optional: true
  belongs_to :partner

  has_many :feedbacks, dependent: :restrict_with_error
  has_many :order_details, dependent: :restrict_with_error

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
  enum type_checkout: { cash: 0, coins: 1, paypal: 2 }
  enum status: { shipping: 0, completed: 1 }

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
    validates :type_checkout
  end

  after_create :update_quantity_sold_of_product
  after_create :update_coins_user, :update_coins_driver, if: :payment_by_coins

  def update_quantity_sold_of_product
    order_details.each do |order_detail|
      order_detail.update_quantity_product
    end
  end

  def payment_by_coins
    type_checkout == "coins"
  end

  def update_coins_user
    if user.coins >= total
      user.update(coins: (user.coins - total))
    end
  end

  def update_coins_driver
    driver.update(coins: (driver.coins + shipping_fee.to_f))
  end

  def as_json(options = {})
    super.merge(delivery_time: delivery_time.strftime('%d-%m-%Y %H:%M'))
  end
end
