class Category < ApplicationRecord
  belongs_to :partner

  has_many :products, dependent: :restrict_with_error

  validates :name, presence: true

  scope :load_category_of_partner, ->(partner_id) { where(partner_id: partner_id) }

  delegate :name, to: :partner, prefix: true
end
