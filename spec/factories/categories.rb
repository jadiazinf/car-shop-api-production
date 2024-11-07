FactoryBot.define do
  factory :category do
    name { Faker::Lorem.words.join(' ') }
    is_active { true }

    trait :invalid do
      name { nil }
      is_active { nil }
    end
  end
end
