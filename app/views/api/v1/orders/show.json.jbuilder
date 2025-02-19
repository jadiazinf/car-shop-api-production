if @order&.errors&.any?
  json.errors @order.errors.full_messages
else
  json.extract! @order, :id, :status, :vehicle_mileage, :is_active, :created_at, :updated_at,
                :vehicle_id, :company_id, :is_checked, :created_by, :assigned_to_id, :created_by_id

  unless @order.assigned_to.nil?
    json.assigned_to do
      json.id @order.assigned_to.id
      json.user_id @order.assigned_to.user_id
      json.company_id @order.assigned_to.company_id
      json.roles @order.assigned_to.roles
      json.is_active @order.assigned_to.is_active
      json.created_at @order.assigned_to.created_at
      json.updated_at @order.assigned_to.updated_at
      json.user do
        json.extract! @order.assigned_to.user, :id, :email, :first_name, :last_name, :dni,
                      :birthdate, :address, :phone_number, :is_active, :gender, :location_id
      end
    end
  end

  json.services_orders do
    json.array! @order.services_orders do |service_order|
      json.id service_order.id
      json.cost service_order.cost
      json.status service_order.status
      json.service_id service_order.service_id
      json.order service_order.order
      json.order_id service_order.order_id
      json.service service_order.service
    end
  end

  json.vehicle do # rubocop:disable Metrics/BlockLength
    json.id @order.vehicle.id
    json.color @order.vehicle.color
    json.license_plate @order.vehicle.license_plate
    json.year @order.vehicle.year
    json.axles @order.vehicle.axles
    json.tires @order.vehicle.tires
    json.load_capacity @order.vehicle.load_capacity
    json.engine_serial @order.vehicle.engine_serial
    json.body_serial @order.vehicle.body_serial
    json.engine_type @order.vehicle.engine_type
    json.transmission @order.vehicle.transmission
    json.is_active @order.vehicle.is_active
    json.model_id @order.vehicle.model_id
    json.brand_id @order.vehicle.model.brand_id
    json.year @order.vehicle.year
    json.brand @order.vehicle.model.brand
    json.vehicle_type @order.vehicle.vehicle_type
    json.user @order.vehicle.user
    json.user_id @order.vehicle.user_id
    json.model do
      json.id @order.vehicle.model.id
      json.name @order.vehicle.model.name
      json.brand do
        json.id @order.vehicle.model.brand.id
        json.name @order.vehicle.model.brand.name
      end
    end

    if @order.vehicle.vehicle_images.attached?
      json.vehicle_images(@order.vehicle.vehicle_images.map { |image| url_for(image) })
    else
      json.vehicle_images nil
    end
  end
end
