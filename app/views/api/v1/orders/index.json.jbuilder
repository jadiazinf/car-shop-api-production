json.current_page @orders.current_page
json.next_page @orders.next_page
json.prev_page @orders.prev_page
json.total_pages @orders.total_pages
json.total_count @orders.total_count

json.data do # rubocop:disable Metrics/BlockLength
  json.array! @orders do |order| # rubocop:disable Metrics/BlockLength
    json.id order.id
    json.status order.status
    json.vehicle_mileage order.vehicle_mileage
    json.is_active order.is_active
    json.created_at order.created_at
    json.updated_at order.updated_at
    json.vehicle_id order.vehicle_id
    json.company_id order.company_id
    json.is_checked order.is_checked
    json.services_orders do
      json.array! order.service_orders do |service_order|
        json.id service_order.id
        json.cost service_order.cost
        json.status service_order.status
        json.service_id service_order.service_id
        json.order_id service_order.order_id
        json.service service_order.service
      end
    end

    json.company do
      json.id order.company.id
      json.name order.company.name
      json.dni order.company.dni
      json.email order.company.email
      json.phone_numbers order.company.phone_numbers
      json.address order.company.address
    end

    json.vehicle do
      vehicle = order.vehicle
      json.id vehicle.id
      json.color vehicle.color
      json.license_plate vehicle.license_plate
      json.year vehicle.year
      json.transmission vehicle.transmission
      json.is_active vehicle.is_active
      json.vehicle_type vehicle.vehicle_type
      json.user vehicle.user

      json.model do
        model = vehicle.model
        json.id model.id
        json.name model.name

        json.brand do
          brand = model.brand
          json.id brand.id
          json.name brand.name
        end
      end
    end
  end
end
