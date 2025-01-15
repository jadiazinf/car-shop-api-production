if @vehicles.present?
  json.current_page @vehicles.current_page
  json.next_page @vehicles.next_page
  json.prev_page @vehicles.prev_page
  json.total_pages @vehicles.total_pages
  json.total_count @vehicles.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do # rubocop:disable Metrics/BlockLength
  json.array! @vehicles do |vehicle| # rubocop:disable Metrics/BlockLength
    json.id vehicle.id
    json.model do
      json.id vehicle.model.id
      json.name vehicle.model.name
      json.brand do
        json.id vehicle.model.brand.id
        json.name vehicle.model.brand.name
      end
    end
    json.color vehicle.color
    json.license_plate vehicle.license_plate
    json.year vehicle.year
    json.axles vehicle.axles
    json.tires vehicle.tires
    json.vehicle_type vehicle.vehicle_type
    json.load_capacity vehicle.load_capacity
    json.engine_serial vehicle.engine_serial
    json.body_serial = vehicle.body_serial
    json.engine_type = vehicle.engine_type
    json.transmission = vehicle.transmission
    json.is_active = vehicle.is_active

    if vehicle.vehicle_images.attached?
      json.vehicle_images(vehicle.vehicle_images.map do |image|
                            url_for(image)
                          end)
    end
  end
end
