FactoryBot.define do
  factory :user_company_request do
    trait :pending_request do
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
      status { 'approved' }
      message { 'Approved' }
    end

    trait :rejected_request do
      status { 'rejected' }
      message { 'Rejected' }
    end

    after(:build) do |user_company_request|
      user_company_request.user_company = create(:user_company, :valid_admin)
    end
  end
end
