require 'rails_helper'

RSpec.describe City, type: :model do
  describe "Associations" do
    it { should have_many(:partners) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(Settings.validation.name_max) }
  end
end
