class Brand < ApplicationRecord
  has_many :models, dependent: :nullify

  ERRORS_KEY = 'active_record.errors.general'.freeze
  validates :name, presence: { message: I18n.t("#{ERRORS_KEY}.blank") },
                   uniqueness: { message: I18n.t('active_record.brands.errors.taken') }
end
