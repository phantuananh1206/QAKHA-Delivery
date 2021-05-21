class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :restrict_with_error
  has_many :orders, through: :order_details
  has_many :carts, dependent: :destroy

  mount_uploader :image, ImageUploader

  enum status: { in_stock: 0, out_of_stock: 1 }

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :quantity_sold, presence: true,
            numericality: {only_integer: true,
                          greater_than_or_equal_to:
                          Settings.validation.number.zero}
  validates :price, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}

  scope :by_ids, ->(ids) { where(id: ids) }
  scope :order_by_create, -> { order created_at: :desc}

  after_save :clear_cache_partners
  after_destroy :clear_cache_partners

  delegate :name, to: :category, prefix: true

  def save_image!(image)
    self.update_columns(image: image)
  end

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def clear_cache_partners
    $redis.del 'partners'
  end
end
