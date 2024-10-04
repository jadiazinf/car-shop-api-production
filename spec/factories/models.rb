FactoryBot.define do
  factory :model do
    trait :invalid_model do
      name { nil }
    end
    trait :valid_model do
      name { Faker::Vehicle.model }
      after(:build) do |model|
        model.brand = create(:brand, :valid_brand)
      end
    end
  end
end
