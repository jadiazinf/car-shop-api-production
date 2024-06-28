if @location&.errors&.any?
  json.errors @location.errors.full_messages
else
  json.extract! @location, :id, :name, :location_type, :is_active, :parent_location_id
end
