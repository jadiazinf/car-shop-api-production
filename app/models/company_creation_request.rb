class CompanyCreationRequest < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company

  validates :status,
            presence: {
              message: I18n.t('active_record.company_creation_requests.errors.status_required')
            }
  validates :company,
            presence: {
              message: I18n.t('active_record.company_creation_requests.errors.company_id_required')
            }
end
