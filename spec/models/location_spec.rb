require 'rails_helper'

RSpec.describe Location do
  context 'with invalid attributes' do
    context 'with name nil' do
      let(:invalid_location) { build(:location, :invalid) }

      it 'Wrong value for name attributes' do
        invalid_location.save
        errors = invalid_location.errors[:name]
        message = I18n.t('active_record.locations.errors.name_required')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with location type invalid' do
      let(:invalid_location) { build(:location, :invalid) }

      it 'Wrong value for locations type' do
        invalid_location.save
        errors = invalid_location.errors[:location_type]
        message = I18n.t('active_record.locations.errors.invalid_location_type',
                         value: invalid_location.location_type)
        expect(errors.include?(message)).to be true
      end
    end
  end

  context 'with valid attributes' do
    let(:valid_location) { build(:location) }

    it 'Correct value for all the attributes' do
      expect(valid_location.valid?).to be true
    end
  end

  context 'when location type value is nil' do
    let(:location) { build(:location, location_type: 'country') }

    it 'is valid without parent_location_id' do
      expect(location).to be_valid
    end
  end

  context 'when parent_location_id value is not nil' do
    let(:country) { create(:location, :country) }
    let(:state) { create(:location, :state) }
    let(:city) { create(:location, :city) }
    let(:town) { create(:location) }

    it 'state should be valid' do
      expect(state).to be_valid
    end

    it 'city should be valid' do
      expect(city).to be_valid
    end

    it 'town should be valid' do
      expect(town).to be_valid
    end

    it 'is not valid for state with incorrect parent_location_id' do
      state.parent_location_id = city.id
      state.valid?
      expect(state.errors[:parent_location_id]).to include(
        I18n.t('active_record.locations.errors.parent_location_id_is_not_a_country')
      )
    end

    it 'is not valid for city with incorrect parent_location_id' do
      city.parent_location_id = country.id
      city.valid?
      expect(city.errors[:parent_location_id]).to include(
        I18n.t('active_record.locations.errors.parent_location_id_is_not_a_state')
      )
    end

    it 'is not valid for town with incorrect parent_location_id' do
      town.parent_location_id = state.id
      town.valid?
      expect(town.errors[:parent_location_id]).to include(
        I18n.t('active_record.locations.errors.parent_location_id_is_not_a_city')
      )
    end
  end
end
