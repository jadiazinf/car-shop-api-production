FactoryBot.define do
  factory :brand do
    trait :valid_brand do
      name { Faker::Vehicle.make }
    end
    trait :invalid_brand do
      name { nil }
    end
  end
end
