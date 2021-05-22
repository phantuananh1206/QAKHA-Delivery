class Coin < ApplicationRecord
  belongs_to :user

  validates :coins_loaded, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}
  validates :loading_form, presence: true,
            length: {maximum: Settings.validation.loading_max}
end
