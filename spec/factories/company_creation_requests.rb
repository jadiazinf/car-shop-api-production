FactoryBot.define do
  factory :company_creation_request do
    association :company

    trait :valid_request do
      status { 'pending' }
      message { nil }
      responder_user_id { nil }
    end

    trait :invalid_request do
      status { nil }
      message { nil }
      responder_user_id { nil }
      company_id { nil }
    end

    trait :approved_request do
      id { 1 }
      status { 'approved' }
      message { 'Approved' }
      responder_user_id { 1 }
      company_id { 1 }
    end
  end
end
