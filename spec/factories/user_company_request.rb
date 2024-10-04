FactoryBot.define do
  factory :user_company_request do
    association :user_company

    trait :valid_request do
      status { 'pending' }
      message { nil }
      responder_user_id { nil }
    end

    trait :invalid_request do
      status { nil }
      message { nil }
      responder_user_id { nil }
      user_company_id { nil }
    end

    trait :approved_request do
      id { 1 }
      status { 'approved' }
      message { 'Approved' }
    end
  end
end
