class Type < ApplicationRecord
  has_many :partners, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
end
