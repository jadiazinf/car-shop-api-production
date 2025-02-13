if @vehicle&.errors&.any?
  json.errors @vehicle.errors.full_messages
else
  json.id @vehicle.id
  json.color @vehicle.color
  json.license_plate @vehicle.license_plate
  json.year @vehicle.year
  json.axles @vehicle.axles
  json.tires @vehicle.tires
  json.load_capacity @vehicle.load_capacity
  json.engine_serial @vehicle.engine_serial
  json.body_serial @vehicle.body_serial
  json.engine_type @vehicle.engine_type
  json.transmission @vehicle.transmission
  json.is_active @vehicle.is_active
  json.model_id @vehicle.model_id
  json.brand_id @vehicle.model.brand_id
  json.year @vehicle.year
  json.brand @vehicle.model.brand
  json.vehicle_type @vehicle.vehicle_type
  json.user @vehicle.user
  json.model do
    json.id @vehicle.model.id
    json.name @vehicle.model.name
    json.brand do
      json.id @vehicle.model.brand.id
      json.name @vehicle.model.brand.name
    end
  end

  if @vehicle.vehicle_images.attached?
    json.vehicle_images(@vehicle.vehicle_images.map { |image| url_for(image) })
  else
    json.vehicle_images nil
  end
end
