class City < ApplicationRecord
  has_many :partners, dependent: :restrict_with_error

  validates :name, presence: true,
            length: {maximum: Settings.validation.name_max}

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |city|
        csv << city.attributes.values_at(*column_names)
      end
    end
  end
end
