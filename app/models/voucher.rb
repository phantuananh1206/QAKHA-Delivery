class Voucher < ApplicationRecord
  belongs_to :partner

  has_many :orders

  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true
  validates :condition, presence: true
  validates :expiry_date, presence: true
  validates :usage_limit, presence: true,
            numericality: {only_integer: true,
                          greater_than_or_equal_to:
                          Settings.validation.number.zero}

  def order_valid_voucher(order_total)
    order_total >= condition &&
      expiry_date >= Time.zone.now &&
      usage_limit >= 1
  end
end
