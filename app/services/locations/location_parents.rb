class Locations::LocationParents
  def initialize(location_id)
    @location = Location.find(location_id)
  end

  def perform
    location_parents = []
    location = @location
    while location.parent_location_id.present?
      location = Location.find(location.parent_location_id)
      location_parents << location
    end
    location_parents
  end
end
