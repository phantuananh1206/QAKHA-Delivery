class Partner < ApplicationRecord
  belongs_to :city

  has_many_attached :images
  has_many :vouchers, dependent: :destroy
end
