FactoryBot.define do
  factory :model do
    trait :invalid_model do
      name { nil }
    end
    trait :valid_model do
      name { Faker::Vehicle.model }
    end
  end
end
