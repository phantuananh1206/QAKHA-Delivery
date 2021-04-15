class Product < ApplicationRecord
  belongs_to :category

  has_one :image, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}
  validates :quantity_sold, presence: true,
            numericality: {only_integer: true,
                          greater_than_or_equal_to:
                          Settings.validation.number.zero}
  validates :price, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}

  scope :by_ids, ->(ids) { where(id: ids) }

  def save_image!(image)
    self.update_columns(image: image)
  end
end
