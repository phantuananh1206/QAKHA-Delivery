class Order < ApplicationRecord
  belongs_to :user
  belongs_to :driver
  belongs_to :voucher

  has_one :feedback

  has_many :order_details, dependent: :destroy

end
