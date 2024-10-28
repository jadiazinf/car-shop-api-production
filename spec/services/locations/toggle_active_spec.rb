require 'rails_helper'

RSpec.describe Locations::ToggleActive do
  let(:location) { build(:location) }

  it 'toggle is_active prop for a location and all its children' do
    toggle = described_class.new(location, false)
    toggle.perform
    expect(location.is_active).to be false
  end
end
