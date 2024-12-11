require 'rails_helper'

RSpec.describe Locations::LocationChildrens do
  let(:town) { create(:location, :town) }

  it 'returns location children' do
    towns = described_class.new(town.parent_location_id).perform
    expect(towns).to eq([town])
  end
end
