require 'rails_helper'

RSpec.describe Voucher, type: :model do
  describe "Associaitons" do
    it { should belong_to(:partner) }
    it { should have_many(:orders) }
  end

  describe "Validations" do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:discount) }
    it { should validate_presence_of(:expiry_date) }
    it { should validate_presence_of(:usage_limit) }
    it { should validate_uniqueness_of(:code) }
  end
end
