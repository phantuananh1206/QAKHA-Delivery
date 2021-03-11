class Voucher < ApplicationRecord
  belongs_to :partner

  has_many :orders, dependent: :destroy
end
