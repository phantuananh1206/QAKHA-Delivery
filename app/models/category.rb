class Category < ApplicationRecord
  belongs_to :partner

  has_many :products, dependent: :destroy

  validates :name, presence: true
end
