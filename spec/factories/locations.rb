FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :location do # rubocop:disable Metrics/BlockLength
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

    trait :valid_country do
      name { Faker::Address.country }
      location_type { 'country' }
      parent_location_id { nil }
    end

    trait :valid_state do
      name { Faker::Address.state }
      location_type { 'state' }
      parent_location_id { create(:location, :valid_country).id }
    end

    trait :valid_city do
      name { Faker::Address.city }
      location_type { 'city' }
      parent_location_id { create(:location, :valid_state).id }
    end

    trait :valid_town do
      name { Faker::Address.street_name }
      location_type { 'town' }
      parent_location_id { create(:location, :valid_city).id }
    end
  end
end
