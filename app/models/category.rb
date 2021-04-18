class Category < ApplicationRecord
  belongs_to :partner

  has_many :products, dependent: :destroy

  validates :name, presence: true
  scope :load_category_of_partner, ->(partner_id) { where(partner_id: partner_id) }
end
