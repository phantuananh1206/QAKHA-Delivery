class Category < ApplicationRecord
  belongs_to :partner

  has_many :products, dependent: :restrict_with_error

  validates :name, presence: true

  scope :load_category_of_partner, ->(partner_id) { where(partner_id: partner_id) }

  delegate :name, to: :partner, prefix: true
  delegate :products, to: :partner, prefix: true

  after_save :clear_cache_partners
  after_destroy :clear_cache_partners

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |category|
        csv << category.attributes.values_at(*column_names)
      end
    end
  end

  def clear_cache_partners
    $redis.del 'partners'
  end
end
