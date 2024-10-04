FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :company do # rubocop:disable Metrics/BlockLength
    name { Faker::Company.name }
    dni { Faker::IdNumber.valid }
    email { Faker::Internet.email }
    number_of_employees { Faker::Number.between(from: 1, to: 100) }
    payment_methods { [Faker::Finance.credit_card] }
    social_networks { [Faker::Internet.url] }
    phone_numbers { [Faker::PhoneNumber.phone_number] }
    address { Faker::Address.full_address }
    is_active { false }

    after(:build) do |company|
      company.location = create(:location, :valid_town)
      company.company_charter.attach(
        io: Rails.root.join('spec/fixtures/files/company_charter.pdf').open,
        filename: 'company_charter.pdf',
        content_type: 'application/pdf'
      )
      company.company_images.attach(
        io: Rails.root.join('spec/fixtures/files/image.jpg').open,
        filename: 'image.jpg',
        content_type: 'image/jpg'
      )
      company.users = [create(:user, :registration)]
    end

    trait :active do
      is_active { true }
    end

    trait :without_dni do
      dni { nil }
    end

    trait :without_name do
      name { nil }
    end

    trait :with_company_charter do
      after(:build) do |company|
        company.company_charter.attach(
          io: Rails.root.join('spec/fixtures/files/company_charter.pdf').open,
          filename: 'company_charter.pdf',
          content_type: 'application/pdf'
        )
      end
    end

    trait :with_invalid_company_charter do
      after(:build) do |company|
        company.company_charter.attach(
          io: Rails.root.join('spec/fixtures/files/image.jpg').open,
          filename: 'image.jpg',
          content_type: 'image/jpg'
        )
      end

      trait :with_valid_images do
        after(:build) do |company|
          company.company_images.attach(
            io: Rails.root.join('spec/fixtures/files/image.jpg').open,
            filename: 'image.jpg',
            content_type: 'image/jpg'
          )
        end
      end
    end

    trait :with_invalid_images do
      after(:build) do |company|
        company.company_images.attach(
          io: Rails.root.join('spec/fixtures/files/company_charter.pdf').open,
          filename: 'company_charter.pdf',
          content_type: 'application/pdf'
        )
      end
    end

    trait :with_valid_files do
      after(:build) do |company|
        company.company_charter.attach(
          io: Rails.root.join('spec/fixtures/files/company_charter.pdf').open,
          filename: 'company_charter.pdf',
          content_type: 'application/pdf'
        )
        company.company_images.attach(
          io: Rails.root.join('spec/fixtures/files/image.jpg').open,
          filename: 'image.jpg',
          content_type: 'image/jpg'
        )
      end
    end
  end
end
