class Vehicle < ApplicationRecord
  belongs_to :model
  belongs_to :user, optional: true
  has_many_attached :vehicle_images

  ERRORS_KEY = 'active_record.errors.general'.freeze

  validates :axles, :tires, :year, :color,
            presence: { message: I18n.t("#{ERRORS_KEY}.blank") }

  validates :transmission,
            presence: { message: I18n.t("#{ERRORS_KEY}.blank") },
            inclusion: {
              in: %w[automatic manual dct cvt],
              message: I18n.t('active_record.vehicles.errors.transmission_invalid_value')
            }

  validates :vehicle_type, :engine_type,
            presence: { message: I18n.t("#{ERRORS_KEY}.blank") }
  validates :load_capacity, presence: { message: I18n.t("#{ERRORS_KEY}.blank") },
                            numericality: { only_integer: true,
                                            message: I18n.t("#{ERRORS_KEY}.format") }
  validates :mileage, presence: { message: I18n.t("#{ERRORS_KEY}.blank") },
                      numericality: { only_integer: true,
                                      message: I18n.t("#{ERRORS_KEY}.format") }

  validates :license_plate, :engine_serial, :body_serial,
            presence: { message: I18n.t("#{ERRORS_KEY}.blank") },
            uniqueness: { message: I18n.t("#{ERRORS_KEY}.taken") }

  validate :vehicle_images_format

  enum :vehicle_type, {
    third_type: I18n.t('active_record.vehicles.attributes.vehicle_type.third'),
    fourth_type: I18n.t('active_record.vehicles.attributes.vehicle_type.fourth'),
    fith_type: I18n.t('active_record.vehicles.attributes.vehicle_type.fith'),
    tsp: I18n.t('active_record.vehicles.attributes.vehicle_type.tsp')
  }

  enum :engine_type, {
    diesel: I18n.t('active_record.vehicles.attributes.engine_types.diesel'),
    gas: I18n.t('active_record.vehicles.attributes.engine_types.gas'),
    gasoline: I18n.t('active_record.vehicles.attributes.engine_types.gasoline'),
    electric: I18n.t('active_record.vehicles.attributes.engine_types.electric'),
    hybrid: I18n.t('active_record.vehicles.attributes.engine_types.hybrid')
  }

  enum :transmission, {
    manual: I18n.t('active_record.vehicles.attributes.transmissions.manual'),
    automatic: I18n.t('active_record.vehicles.attributes.transmissions.automatic'),
    cvt: I18n.t('active_record.vehicles.attributes.transmissions.cvt'),
    dct: I18n.t('active_record.vehicles.attributes.transmissions.dct')
  }

  private

  IMAGE_WRONG_FORMAT_MESSAGE = I18n.t('active_record.vehicles.errors.invalid_images_format')

  def vehicle_images_format
    vehicle_images.each do |image|
      unless ['image/png', 'image/jpg', 'image/jpeg'].include?(image.content_type)
        errors.add(:vehicle_images, IMAGE_WRONG_FORMAT_MESSAGE)
      end
    end
  end
end
