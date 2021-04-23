class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
            length: {maximum: Settings.validation.address_max}
  geocoded_by :name
  after_validation :geocode, if: :name_changed?

  delegate :name, to: :user, prefix: true

  def self.to_xls
    CSV.generate do |csv|
      csv << column_names
      all.each do |address|
        csv << address.attributes.values_at(*column_names)
      end
    end
  end
end
