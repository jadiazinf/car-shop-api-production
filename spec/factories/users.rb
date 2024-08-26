FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :user do # rubocop:disable Metrics/BlockLength
    trait :with_invalid_attr do
      email { nil }
      password { '64544564' }
      password_confirmation { '12344323' }
      first_name { nil }
      last_name { nil }
      dni { nil }
      birthdate { nil }
      roles { nil }
      is_active { nil }
      gender { nil }
    end
    trait :with_valid_attr do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      password_confirmation { password }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      dni { Faker::IdNumber.valid }
      birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
      roles { ['admin'] }
      is_active { true }
      address { Faker::Address.full_address }
      phonenumber { Faker::PhoneNumber.cell_phone }
      gender { Faker::Gender.binary_type }
    end
    trait :registration do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      password_confirmation { password }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      dni { Faker::IdNumber.valid }
      birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
      address { Faker::Address.full_address }
      phonenumber { Faker::PhoneNumber.cell_phone }
      gender { Faker::Gender.binary_type }
    end
  end
end
