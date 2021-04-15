class Type < ApplicationRecord
  has_many :partners, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true,
            length: {maximum: Settings.validation.name_max}
end
