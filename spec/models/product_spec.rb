require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Associations" do
    it { should belong_to(:category) }
    it { should have_many(:order_details) }
    it { should have_many(:carts) }
    it { should have_many(:orders).through(:order_details) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity_sold) }
    it { should validate_presence_of(:price) }
    it { should validate_length_of(:name).is_at_most(Settings.validation.name_max) }
  end
end
