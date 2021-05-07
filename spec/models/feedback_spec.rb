require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:order) }
    it { should belong_to(:driver).optional }
    it { should belong_to(:partner).optional }
  end

  describe "Validations" do
    it { should validate_presence_of(:point) }
  end
end
