class Service < ApplicationRecord
  has_many :company_services, dependent: :nullify
  has_many :companies, through: :company_services

  validates :name, :service_type, :description, presence: true
end
