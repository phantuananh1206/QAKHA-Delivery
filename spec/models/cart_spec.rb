require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "Associations" do
    it { should belong_to(:product) }
    it { should belong_to(:user) }
    it { should belong_to(:partner) }
  end

  describe "Validations" do
    it { should validate_presence_of(:quantity) }
  end

end
