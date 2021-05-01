class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :driver, optional: true
  belongs_to :partner, optional: true

  mount_uploader :image, ImageUploader

  validates :point, presence: true,
            numericality: { only_integer: true,
                            greater_than: Settings.validation.min_point,
                            less_than: Settings.validation.max_point}

  def as_json(options = {})
    super.merge(created_at: created_at.strftime('%d-%m-%Y %H:%M'))
  end

  def save_image!(image)
    self.update_columns(image: image)
  end
end
