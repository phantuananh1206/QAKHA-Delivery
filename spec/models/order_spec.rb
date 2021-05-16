require 'rails_helper'
require "factories/orders"

RSpec.describe Order, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:driver) }
    it { should belong_to(:voucher).optional }
    it { should belong_to(:partner) }
    it { should have_many(:feedbacks) }
    it { should have_many(:order_details) }
    it { should have_many(:products).through(:order_details) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:subtotal) }
    it { should validate_presence_of(:shipping_fee) }
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:type_checkout) }
    it { should validate_length_of(:name).is_at_most(Settings.validation.name_max) }
    it { should validate_length_of(:subtotal).is_at_least(Settings.validation.number.zero) }
    it { should validate_length_of(:shipping_fee).is_at_least(Settings.validation.number.zero) }
    it { should validate_length_of(:total).is_at_least(Settings.validation.number.zero) }
    it { should validate_length_of(:phone_number).is_at_least(Settings.validation.phone_min) }
  end
end
