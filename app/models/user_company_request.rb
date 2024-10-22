class UserCompanyRequest < ApplicationRecord
  self.table_name = 'users_companies_requests'
  belongs_to :user_company
  belongs_to :user, foreign_key: :responder_user_id, inverse_of: :user_company_requests
  delegate :user, to: :user_company
  delegate :company, to: :user_company

  validates :status,
            presence: {
              message: I18n.t('active_record.users_companies_requests.errors.status_required')
            }
  validates :company,
            presence: {
              message: I18n.t('active_record.users_companies_requests.errors.company_id_required')
            }

  private

  def validate_unique_user_for_company_creation
    return unless UserCompanyRequest.exists?(company_id:)

    company_owner = UserCompanyRequest.where(company_id:).order(created_at: :desc).first
    return unless user[:id] != company_owner[:user_id]

    error = 'active_record.users_companies_requests.errors.another_user_already_requested'
    errors.add(:user_id, I18n.t(error))
  end
end
