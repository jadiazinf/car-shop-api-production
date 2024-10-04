class UserCompany < ApplicationRecord
  self.table_name = 'users_companies'
  belongs_to :user
  belongs_to :company

  validates :user, presence: { message: I18n.t('active_record.user_company.errors.user_required') }
  validates :company,
            presence: { message: I18n.t('active_record.user_company.errors.company_required') }

  validates :roles, presence: { message: I18n.t('active_record.user_company.errors.roles') },
                    inclusion: { in: %w[admin general superadmin supervisor technical],
                                 message: I18n.t('active_record.users.errors.invalid_role') }
end
