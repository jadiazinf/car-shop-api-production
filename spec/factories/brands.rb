FactoryBot.define do
  factory :brand do
    name { Faker::Vehicle.make }

    trait :invalid_brand do
      name { nil }
    end
  end
end
