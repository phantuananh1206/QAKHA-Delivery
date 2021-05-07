require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe "Associaitons" do
    it { should have_many(:orders) }
    it { should have_many(:feedbacks) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:id_card) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:license_plate) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:id_card).case_insensitive }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
    it { should validate_length_of(:name).is_at_most(Settings.validation.name_max) }
    it { should validate_length_of(:email).is_at_most(Settings.validation.email_max) }
    it { should validate_length_of(:id_card).is_at_least(Settings.validation.id_card_min) }
    it { should validate_length_of(:phone_number).is_at_least(Settings.validation.phone_min) }
    it { should validate_length_of(:password).is_at_least(Settings.validation.password_min) }
    it { should allow_value(nil).for(:phone_number) }
    it { should allow_value(nil).for(:coins) }
  end
end
