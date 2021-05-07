require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  describe "Associations" do
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end

  describe "Validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
  end
end
