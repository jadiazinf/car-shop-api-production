class CompanyService < ApplicationRecord
  belongs_to :service
  belongs_to :company

  validates :price, presence: true
end
