class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
            length: {maximum: Settings.validation.address_max}
end
