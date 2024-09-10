class Company < ApplicationRecord
  has_many :users, dependent: :nullify
  belongs_to :location, optional: false

  ERRORS_KEY = 'active_record.errors.general'.freeze

  validates :name, :email, :phonenumbers, :address, :company_charter, :dni, :payment_methods,
            :request_status, presence: true

  validates :request_status,
            inclusion: {
              in: %w[pending approved rejected],
              message: I18n.t('active_record.companies.errors.request_status.invalid')
            }
end
