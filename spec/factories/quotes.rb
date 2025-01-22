FactoryBot.define do
  factory :quote do
    group_id { SecureRandom.uuid }
    total_cost { Faker::Number.decimal(l_digits: 2) }
    date { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    note { Faker::Lorem.sentence }
    status_by_company { Quote::QUOTE_STATUSES.sample }
    status_by_client { Quote::QUOTE_STATUSES.sample }
    vehicle_id { create(:vehicle).id }
    service_id { create(:service).id }
  end
end
