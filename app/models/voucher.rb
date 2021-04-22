class Voucher < ApplicationRecord
  belongs_to :partner

  has_many :orders, dependent: :restrict_with_error

  enum status: { not_activated: 0, effective: 1, void: 2 }

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

  def update_status_voucher
    if expiry_date < Time.zone.now
      self.update_columns(status: 2)
    elsif status == "void"
      self.update_columns(status: 1)
    end
    return status
  end
end
