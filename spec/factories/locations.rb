FactoryBot.define do
  factory :location do
    name { Faker::Address.country }
    location_type { 'town' }
    parent_location_id { create(:location, :city).id }

    trait :invalid do
      name { nil }
      location_type { 'region' }
      parent_location_id { nil }
    end

    trait :state do
      name { Faker::Address.state }
      location_type { 'state' }
      parent_location_id { create(:location, :country).id }
    end

    trait :city do
      name { Faker::Address.city }
      location_type { 'city' }
      parent_location_id { create(:location, :state).id }
    end

    trait :country do
      name { Faker::Address.city }
      location_type { 'country' }
      parent_location_id { nil }
    end
  end
end
