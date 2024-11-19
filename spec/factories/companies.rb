FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    dni { Faker::IdNumber.valid }
    email { Faker::Internet.email }
    number_of_employees { Faker::Number.between(from: 1, to: 100) }
    payment_methods { [Faker::Finance.credit_card] }
    social_networks { [Faker::Internet.url] }
    phone_numbers { [Faker::PhoneNumber.phone_number] }
    address { Faker::Address.full_address }
    is_active { false }
    location factory: %i[location], strategy: :create
    users { [create(:user, :registration)] }
  end
end
