class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :driver
end
