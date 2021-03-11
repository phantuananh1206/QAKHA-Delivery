class User < ApplicationRecord
  has_many_attached :images
  has_many :orders, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  enum role: {admin: 0, member: 1, block: 2}
end
