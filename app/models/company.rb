class Company < ApplicationRecord
  has_many :users, dependent: :nullify
  belongs_to :location, optional: false

  ERRORS_KEY = 'active_record.errors.general'.freeze

  validates :name, :email, :phonenumbers, :address, :company_charter, :dni, :payment_methods,
            presence: true
end
