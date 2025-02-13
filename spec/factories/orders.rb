FactoryBot.define do
  factory :order do
    status { 'in_progress' }
    vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
    is_active { true }
    is_checked { true }
    created_by factory: %i[user_company valid_admin], strategy: :create
    company { created_by.company }
    vehicle factory: %i[vehicle], strategy: :create

    trait :quote_created_by_user do
      status { 'quote' }
      vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
      is_active { true }
      is_checked { false }
      created_by { nil }
      company factory: %i[company active_company], strategy: :create
    end

    trait :quote_created_by_company do
      status { 'quote' }
      vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
      is_active { true }
      is_checked { false }
      created_by factory: %i[user_company valid_admin], strategy: :create
      company { created_by.company }
    end

    trait :unactive_order do
      status { 'in_progress' }
      vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
      is_active { false }
      is_checked { true }
      created_by factory: %i[user_company valid_admin], strategy: :create
      company { created_by.company }
      vehicle factory: %i[vehicle], strategy: :create
    end

    trait :finished_order do
      status { 'finished' }
      vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
      is_active { false }
      is_checked { true }
      created_by factory: %i[user_company valid_admin], strategy: :create
      company { created_by.company }
      vehicle factory: %i[vehicle], strategy: :create
    end

    trait :canceled_order do
      status { 'canceled' }
      vehicle_mileage { Faker::Number.between(from: 1000, to: 200_000) }
      is_active { false }
      is_checked { true }
      created_by factory: %i[user_company valid_admin], strategy: :create
      company { created_by.company }
      vehicle factory: %i[vehicle], strategy: :create
    end
  end
end
