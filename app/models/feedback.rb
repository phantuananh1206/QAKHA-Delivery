class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :driver

  validates :point, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}
end
