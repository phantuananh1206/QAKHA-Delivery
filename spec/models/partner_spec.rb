require 'rails_helper'

RSpec.describe Partner, type: :model do
  describe "Associaitons" do
    it { should have_many(:vouchers) }
    it { should have_many(:categories) }
    it { should have_many(:feedbacks) }
    it { should have_many(:orders) }
    it { should have_many(:products).through(:categories) }
  end

  describe "Validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
  end
end
