class Voucher < ApplicationRecord
  belongs_to :partner

  has_many :orders, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true
  validates :condition, presence: true
  validates :expiry_date, presence: true
  validates :usage_limit, presence: true,
            numericality: {only_integer: true,
                          greater_than_or_equal_to:
                          Settings.validation.number.zero}
end
