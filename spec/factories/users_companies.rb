FactoryBot.define do
  factory :user_company do
    user factory: %i[user registration], strategy: :create
    company factory: %i[company], strategy: :create

    trait :invalid_role do
      roles { ['whatever'] }
      is_active { true }
    end

    trait :valid_admin do
      roles { ['admin'] }
      is_active { true }
    end

    trait :valid_technical do
      roles { ['technical'] }
      is_active { true }
    end

    trait :valid_superadmin do
      roles { ['superadmin'] }
      is_active { true }
    end

    trait :not_active do
      roles { ['admin'] }
      is_active { false }
    end
  end
end
