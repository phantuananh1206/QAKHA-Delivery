FactoryBot.define do
  factory :coin do
    coins_loaded { 1.5 }
    loading_form { "MyString" }
    user { nil }
  end
end
