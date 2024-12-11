class Locations::LocationChildrens
  attr_reader :location

  def initialize(location_id)
    @location = Location.find(location_id)
  end

  def perform
    Location.where(parent_location_id: location.id)
  end
end
