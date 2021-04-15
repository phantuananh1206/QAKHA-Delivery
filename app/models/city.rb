class City < ApplicationRecord
  has_many :partners, dependent: :restrict_with_error

  validates :name, presence: true
end
