FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :company do # rubocop:disable Metrics/BlockLength
    name { Faker::Company.name }
    dni { Faker::IdNumber.valid }
    company_charter { Faker::Company.industry }
    email { Faker::Internet.email }
    number_of_employees { Faker::Number.number(digits: 2) }
    payment_methods { %w[debit pos cash] }
    social_networks { %w[facebook instagram twitter] }
    phonenumbers { [Faker::PhoneNumber.cell_phone] }
    address { Faker::Address.full_address }
    location

    trait :with_specific_location do
      after(:build) do |company|
        company.location = create(:location, :town)
      end
    end

    trait :invalid_company do
      name { nil }
      dni { nil }
      company_charter { nil }
      email { nil }
      number_of_employees { nil }
      payment_methods { nil }
      social_networks { nil }
      phonenumbers { nil }
      address { nil }
      location_id { nil }
    end
  end
end
