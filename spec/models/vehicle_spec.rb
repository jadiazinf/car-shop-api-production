require 'rails_helper'

RSpec.describe Vehicle do
  context 'when the attributes are invalid' do
    let(:invalid_vehicle) { build(:vehicle, :invalid) }

    context 'with blank license_plate' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:license_plate]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with blank year' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:year]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with blank axles' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:axles]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with blank color' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:color]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with blank tires' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:tires]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil vehicle_type' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:vehicle_type]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil load_capacity' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:load_capacity]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with invalid load_capacity format' do
      it 'show correct error message' do
        invalid_vehicle.load_capacity = 1.5
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:load_capacity]
        message = I18n.t('active_record.errors.general.format')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil mileage' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:mileage]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with invalid mileage format' do
      it 'show correct error message' do
        invalid_vehicle.mileage = 1.5
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:mileage]
        message = I18n.t('active_record.errors.general.format')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil engine_type' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:engine_type]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil engine_serial' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:engine_serial]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil body_serial' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:body_serial]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end

    context 'with nil transmission' do
      it 'show correct error message' do
        invalid_vehicle.save
        errors = invalid_vehicle.errors[:transmission]
        message = I18n.t('active_record.errors.general.blank')
        expect(errors.include?(message)).to be true
      end
    end
  end

  context 'when the attributes are valid' do
    let(:brand) { create(:brand, :valid_brand) }
    let(:model) { create(:model, :valid_model, brand:) }
    let(:user) { create(:user, :with_valid_attr) }
    let(:vehicle) { build(:vehicle, user:, model:) }
    it 'is valid' do
      expect(vehicle.valid?).to be true
    end
  end
end
