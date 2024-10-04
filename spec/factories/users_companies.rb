FactoryBot.define do
  factory :user_company do
    association :user, factory: %i[user registration], strategy: :create
    association :company, factory: :company, strategy: :create

    trait :invalid_role do
      roles { ['whatever'] }
      is_active { true }
    end

    trait :valid_admin do
      roles { ['admin'] }
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

# after(:build) do |user_company|
#   company = create(:company)
#   user_company.company = company
#   user_company.user = company.users.first
# end
