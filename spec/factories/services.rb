FactoryBot.define do
  factory :service do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 1.00..1000.00) }
    is_active { true }
    company factory: %i[company active_company], strategy: :create
    category factory: %i[category], strategy: :create

    trait :invalid_service do
      name { nil }
      description { nil }
      is_active { nil }
    end
  end
end
