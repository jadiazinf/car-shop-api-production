FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :vehicle do # rubocop:disable Metrics/BlockLength
    year { Time.zone.now.year }
    color { Faker::Vehicle.color }
    license_plate { Faker::Vehicle.license_plate }
    vehicle_type { Vehicle.vehicle_types['third_type'] }
    engine_type { Vehicle.engine_types['diesel'] }
    load_capacity { Faker::Number.number(digits: 4) }
    mileage { Faker::Vehicle.mileage }
    engine_serial { Faker::Vehicle.vin }
    body_serial { Faker::Vehicle.vin }
    transmission { Vehicle.transmissions['automatic'] }
    axles { 2 }
    tires { 4 }
    after(:build) do |vehicle|
      vehicle.model = create(:model, :valid_model)
      vehicle.user = create(:user, :registration)
    end

    trait :invalid do
      year { nil }
      color { nil }
      license_plate { nil }
      vehicle_type { nil }
      engine_type { nil }
      load_capacity { nil }
      mileage { nil }
      engine_serial { nil }
      body_serial { nil }
      transmission { nil }
      axles { nil }
      tires { nil }
      vehicle_images { nil }
    end
  end
end
