class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :vehicles, dependent: :nullify

  has_many :user_companies, dependent: :destroy
  has_many :companies, through: :user_companies

  belongs_to :location

  validates :email, presence: { message: I18n.t('active_record.users.errors.email') },
                    uniqueness: { message: I18n.t('active_record.users.errors.unique_email') }
  validates :password, presence: {
    message: I18n.t('active_record.users.errors.password')
  }, if: lambda {
    new_record? || password.present?
  }
  validates :password_confirmation, presence: {
    message: I18n.t('active_record.users.errors.password_confirmation')
  }, if: -> { new_record? || password.present? }
  validate :password_confirmation_is_valid?, if: -> { new_record? || password.present? }

  validates :first_name, presence: { message: I18n.t('active_record.users.errors.first_name') }
  validates :last_name, presence: { message: I18n.t('active_record.users.errors.last_name') }
  validates :dni, presence: { message: I18n.t('active_record.users.errors.dni') },
                  uniqueness: { message: I18n.t('active_record.users.errors.unique_dni') }
  validates :gender, presence: { message: I18n.t('active_record.users.errors.gender') },
                     inclusion: { in: %w[Male Female],
                                  message: I18n.t('active_record.users.errors.gender_value') }
  validates :birthdate, presence: { message: I18n.t('active_record.users.errors.birthdate') }

  validate :validate_location

  def roles(company_id)
    UserCompany.where(user_id: id, company_id:).first.roles
  end

  private

  def password_confirmation_is_valid?
    return false unless password.present? && password != password_confirmation

    errors.add(:password_confirmation, I18n.t('active_record.users.errors.password_not_match'))
  end

  def validate_location
    location = Location.find(location_id)
    if location.location_type != 'town'
      errors.add(:location_id, I18n.t('active_record.users.errors.invalid_location_type'))
    end
    false
  end
end
