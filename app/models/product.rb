class Product < ApplicationRecord
  belongs_to :category
  belongs_to :partner

  has_many_attached :images
end
