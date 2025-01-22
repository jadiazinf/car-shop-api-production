class Quote < ApplicationRecord
  belongs_to :vehicle
  belongs_to :service

  QUOTE_STATUSES = %w[pending approved rejected].freeze

  validates :status_by_company, inclusion: { in: QUOTE_STATUSES }
  validates :status_by_client, inclusion: { in: QUOTE_STATUSES }
end
