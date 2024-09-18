class Company < ApplicationRecord
  has_many :users, dependent: :nullify
  belongs_to :location, optional: false
  has_one_attached :company_charter
  has_many_attached :company_images

  ERRORS_KEY = 'active_record.errors.general'.freeze

  IMAGE_WRONG_FORMAT_MESSAGE = I18n.t('active_record.companies.errors.wrong_company_images_format')
  SIZE_EXCEEDED_MESSAGE = I18n.t('active_record.companies.errors.image_size_exceeded')

  validates :name, :email, :address, :dni, :company_charter, :company_images, :user_ids,
            :number_of_employees, presence: true

  validate :validate_company_charter
  validate :validate_company_images
  validate :validate_location_type

  private

  def validate_location_type
    return if location.nil? || location.location_type == 'town'

    errors.add(:location_id, I18n.t('active_record.companies.errors.wrong_location_type'))
  end

  def validate_company_charter
    return unless company_charter.attached? && company_charter.content_type != 'application/pdf'

    errors.add(:company_charter,
               I18n.t('active_record.companies.errors.wrong_company_charter_format'))
  end

  def validate_company_images
    return unless company_images.attached?

    company_images.each do |image|
      unless ['image/png', 'image/jpg', 'image/jpeg'].include?(image.content_type)
        errors.add(:company_images, IMAGE_WRONG_FORMAT_MESSAGE)
      end

      errors.add(:company_images, SIZE_EXCEEDED_MESSAGE) if image.byte_size > 5.megabytes
    end
  end
end
