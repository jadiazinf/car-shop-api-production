FactoryBot.define do
  factory :location do
    name { Faker::Address.country }
    location_type { 'country' }
    parent_location_id { nil }

    trait :invalid do
      name { nil }
      location_type { 'region' }
      parent_location_id { nil }
    end

    trait :state do
      name { Faker::Address.state }
      location_type { 'state' }
      parent_location_id { nil }
    end

    trait :city do
      name { Faker::Address.city }
      location_type { 'city' }
      parent_location_id { nil }
    end

    trait :town do
      name { Faker::Address.city }
      location_type { 'town' }
      parent_location_id { nil }
    end
  end
end
