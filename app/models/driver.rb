class Driver < ApplicationRecord
  has_one_attached :avatar
  has_one :feedback

  has_many :orders, dependent: :destroy
end
