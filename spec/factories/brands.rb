FactoryBot.define do
  factory :brand do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }

    trait :invalid_brand do
      name { nil }
    end
  end
end
