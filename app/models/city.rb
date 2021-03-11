class City < ApplicationRecord
  has_many :partners, dependent: :destroy
end
