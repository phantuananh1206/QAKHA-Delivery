class Type < ApplicationRecord
  has_many :partners, dependent: :restrict_with_error

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}

  scope :_created_at_desc, -> { order(created_at: :desc) }

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |type|
        csv << type.attributes.values_at(*column_names)
      end
    end
  end
end
