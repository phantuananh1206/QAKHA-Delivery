class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than: Settings.validation.number.zero}
  validates :price, presence: true,
            numericality: {greater_than: Settings.validation.number.zero}

  scope :_created_at_desc, -> { order(created_at: :desc) }

  def update_quantity_product
    product.update(quantity_sold: (product.quantity_sold + quantity))
  end

  def restock_product
    product.update(quantity_sold: (product.quantity_sold - quantity))
  end
end
