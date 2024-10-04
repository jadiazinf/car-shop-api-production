require 'rails_helper'

RSpec.describe User do
  context 'create.rb user ' do
    context 'cant create.rb user with invalid attributes' do
      let(:invalid_user) { build(:user, :with_invalid_attr) }

      it 'Wrong values for create.rb new user' do
        invalid_user.save
        errors = invalid_user.errors
        expect(errors[:email].include?(I18n.t('active_record.users.errors.email'))).to be true
      end
      it 'Password not match' do
        invalid_user.save
        errors = invalid_user.errors
        expected = I18n.t('active_record.users.errors.password_not_match')
        expect(errors[:password_confirmation][1].include?(expected)).to be true
      end
      it 'First name required' do
        invalid_user.save
        errors = invalid_user.errors
        expected = I18n.t('active_record.users.errors.first_name')
        expect(errors[:first_name].include?(expected)).to be true
      end
      it 'Last name required' do
        invalid_user.save
        errors = invalid_user.errors
        expected = I18n.t('active_record.users.errors.last_name')
        expect(errors[:last_name].include?(expected)).to be true
      end
      it 'DNI required' do
        invalid_user.save
        errors = invalid_user.errors
        expected = I18n.t('active_record.users.errors.dni')
        expect(errors[:dni].include?(expected)).to be true
      end
      it 'Birthdate required' do
        invalid_user.save
        errors = invalid_user.errors
        expected = I18n.t('active_record.users.errors.birthdate')
        expect(errors[:birthdate].include?(expected)).to be true
      end
    end
    context 'create.rb user with valid attributes' do
      let(:valid_user) { build(:user, :with_valid_attr) }
      it 'Correct values for create.rb new user' do
        expect(valid_user.valid?).to be true
      end
    end
  end
end
