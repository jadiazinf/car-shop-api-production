class Locations::ToggleActive
  def initialize(location, status)
    @location = location
    @status = status
  end
  attr_accessor :location, :status

  def perform(location_child = nil)
    id = location_child.nil? ? location.id : location_child.id
    locations = Location.where(parent_location_id: id)
    locations.each do |loc|
      perform(loc)
      loc.update(is_active: status)
    end
    location.update(is_active: status) if location_child.nil?
  end
end
