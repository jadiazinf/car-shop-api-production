class UserCompany < ApplicationRecord
  self.table_name = 'users_companies'
  belongs_to :user
  belongs_to :company
  has_many :orders, foreign_key: 'assigned_to', dependent: :nullify, inverse_of: :user_company

  validates :user, presence: { message: I18n.t('active_record.user_company.errors.user_required') }
  validates :company,
            presence: { message: I18n.t('active_record.user_company.errors.company_required') }

  validate_company_id_message = 'active_record.user_company.errors.user_is_already_registered'

  validates :company_id,
            uniqueness: { scope: :user_id,
                          message: I18n.t(validate_company_id_message) }

  validates :roles, presence: { message: I18n.t('active_record.user_company.errors.roles') },
                    inclusion: { in: %w[admin general superadmin supervisor technical],
                                 message: I18n.t('active_record.users.errors.invalid_role') }
end
