class Location < ApplicationRecord
  belongs_to :locations, class_name: 'Location', optional: true
  validates :name, presence: { message: I18n.t('active_record.locations.errors.name_required') }
  validates :location_type,
            inclusion: { in: %w[country state city town],
                         message: I18n.t('active_record.locations.errors.invalid_location_type') }
  validates :parent_location_id, presence: {
    message: I18n.t('active_record.locations.errors.parent_location_id_required')
  }, if: lambda {
           location_type != 'country'
         }

  validate :validate_parent_based_on_type

  private

  def validate_parent_is_a_country
    if location_type == 'state' && Location.exists?(parent_location_id) &&
        Location.find(parent_location_id).location_type != 'country'
      errors.add(:parent_location_id,
                 I18n.t('active_record.locations.errors.parent_location_id_is_not_a_country'))
    end
  end

  def validate_parent_is_a_city
    if location_type == 'city' && Location.exists?(parent_location_id) &&
        Location.find(parent_location_id).location_type != 'state'
      errors.add(:parent_location_id,
                 I18n.t('active_record.locations.errors.parent_location_id_is_not_a_state'))
    end
  end

  def validate_parent_is_a_state
    if location_type == 'town' && Location.exists?(parent_location_id) &&
        Location.find(parent_location_id).location_type != 'city'
      errors.add(:parent_location_id,
                 I18n.t('active_record.locations.errors.parent_location_id_is_not_a_city'))
    end
  end

  def validate_parent_based_on_type
    validate_parent_is_a_country
    validate_parent_is_a_city
    validate_parent_is_a_state
  end
end
