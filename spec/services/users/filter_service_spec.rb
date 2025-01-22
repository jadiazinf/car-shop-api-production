require 'rails_helper'

RSpec.describe Users::FilterService do
  describe '#perform' do
    let(:user_a) { create(:user, :registration) }

    it 'filters by name' do
      params = { name: user_a.first_name }
      result = described_class.new(params).perform
      expect(result).to contain_exactly(user_a)
    end

    it 'filters by email' do
      params = { email: user_a.email }
      result = described_class.new(params).perform
      expect(result).to contain_exactly(user_a)
    end

    it 'filters by dni' do
      params = { dni: user_a.dni }
      result = described_class.new(params).perform
      expect(result).to contain_exactly(user_a)
    end

    it 'filters by multiple parameters' do
      params = { name: user_a.first_name, email: user_a.email }
      result = described_class.new(params).perform
      expect(result).to contain_exactly(user_a)
    end
  end
end
