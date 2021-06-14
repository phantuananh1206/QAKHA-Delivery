class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :partner

  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than:
                           Settings.validation.number.zero}

  scope :_created_at_desc, -> { order(created_at: :desc) }
end
