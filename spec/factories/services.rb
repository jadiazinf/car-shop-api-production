FactoryBot.define do
  factory :service do
    name { Faker::Commerce.product_name }
    service_type { %w[Mecánico Eléctrico Pintura Mantenimiento].sample }
    description { Faker::Lorem.sentence }

    trait :invalid_service do
      name { nil }
      service_type { nil }
      description { nil }
    end
  end
end
