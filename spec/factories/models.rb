FactoryBot.define do
  factory :model do
    name { Faker::Vehicle.model }
    brand { association(:brand) }

    trait :invalid_model do
      name { nil }
    end
  end
end
