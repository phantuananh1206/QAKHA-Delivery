class Category < ApplicationRecord
  belongs_to :partner

  has_many :products, dependent: :restrict_with_error

  validates :name, presence: true
end
