class Company < ApplicationRecord
  # missing profile image specs
  belongs_to :location, optional: false
  has_many :user_companies, dependent: :destroy
  has_many :average_response_times, dependent: :destroy
  has_many :users, through: :user_companies
  has_one_attached :company_charter
  has_one_attached :profile_image
  has_many_attached :company_images
  has_many :services, dependent: :destroy
  has_many :orders, dependent: :destroy

  ERRORS_KEY = 'active_record.errors.general'.freeze

  IMAGE_WRONG_FORMAT_MESSAGE = I18n.t('active_record.companies.errors.wrong_company_images_format')
  SIZE_EXCEEDED_MESSAGE = I18n.t('active_record.companies.errors.image_size_exceeded')

  validates :name, :email, :address, :dni,
            :number_of_employees, presence: true

  validates :dni, uniqueness: { message: I18n.t('active_record.companies.errors.unique_dni') }
  validates :email, uniqueness: { message: I18n.t('active_record.companies.errors.unique_email') }
  validate :validate_type

  private

  def validate_type
    return if location.nil? || location.location_type == 'town'

    errors.add(:location_id, I18n.t('active_record.companies.errors.wrong_location_type'))
  end
end
