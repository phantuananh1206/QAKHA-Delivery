class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
            length: {maximum: Settings.validation.address_max}
  geocoded_by :name
  after_validation :geocode, if: :name_changed?
end
