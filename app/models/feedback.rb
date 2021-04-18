class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :driver, optional: true
  belongs_to :partner

  mount_uploader :image, ImageUploader

  validates :point, presence: true,
            numericality: { only_integer: true,
                            greater_than: Settings.validation.min_point,
                            less_than: Settings.validation.max_point}

  scope :_feedback_partner, -> { where(driver_id: nil)}

  def as_json(options = {})
    super.merge(created_at: created_at.strftime('%d-%m-%Y %H:%M'))
  end
end
