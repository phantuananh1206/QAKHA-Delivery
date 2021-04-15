class City < ApplicationRecord
  has_many :partners, dependent: :destroy

  validates :name, presence: true
end
