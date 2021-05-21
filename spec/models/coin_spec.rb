require 'rails_helper'

RSpec.describe Coin, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:coins_loaded) }
    it { should validate_presence_of(:loading_form) }
    it { should validate_length_of(:loading_form).is_at_most(Settings.validation.loading_max) }
  end
end
