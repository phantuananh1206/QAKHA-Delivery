class Image < ApplicationRecord
  belongs_to :user
  belongs_to :driver
  belongs_to :partner
  belongs_to :product
end
