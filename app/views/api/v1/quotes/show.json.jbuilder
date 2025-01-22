if @quote&.errors&.any?
  json.errors @quote.errors.full_messages
else
  json.extract! @quote, :id, :group_id, :total_cost, :date, :note, :status_by_company,
                :status_by_client, :vehicle_id, :service_id, :created_at

  json.service do # rubocop:disable Metrics/BlockLength
    if @quote.service.present?
      json.extract! @quote.service, :id, :name, :description if @quote.service.present?
      json.company do # rubocop:disable Metrics/BlockLength
        json.id @quote.service.company.id
        json.name @quote.service.company.name
        json.dni @quote.service.company.dni
        json.email @quote.service.company.email
        json.number_of_employees @quote.service.company.number_of_employees
        json.payment_methods @quote.service.company.payment_methods
        json.social_networks @quote.service.company.social_networks
        json.phone_numbers @quote.service.company.phone_numbers
        json.address @quote.service.company.address
        json.is_active @quote.service.company.is_active
        json.location_id @quote.service.company.location_id

        if @quote.service.company.profile_image.attached?
          json.profile_image_url url_for(@quote.service.company.profile_image)
        else
          json.profile_image_url nil
        end

        if @quote.service.company.company_images.attached?
          json.company_images(@quote.service.company.company_images.map { |image| url_for(image) })
        else
          json.company_images nil
        end

        if @quote.service.company.company_charter.attached?
          json.company_charter url_for(@quote.service.company.company_charter)
        else
          json.company_charter nil
        end
      end
    else
      json.null!
    end
  end

  json.vehicle do # rubocop:disable Metrics/BlockLength
    if @quote.vehicle.present?
      json.id @quote.vehicle.id
      json.color @quote.vehicle.color
      json.license_plate @quote.vehicle.license_plate
      json.year @quote.vehicle.year
      json.axles @quote.vehicle.axles
      json.tires @quote.vehicle.tires
      json.load_capacity @quote.vehicle.load_capacity
      json.engine_serial @quote.vehicle.engine_serial
      json.body_serial @quote.vehicle.body_serial
      json.engine_type @quote.vehicle.engine_type
      json.transmission @quote.vehicle.transmission
      json.is_active @quote.vehicle.is_active
      json.model_id @quote.vehicle.model_id
      json.brand_id @quote.vehicle.model.brand_id
      json.year @quote.vehicle.year
      json.brand @quote.vehicle.model.brand
      json.vehicle_type @quote.vehicle.vehicle_type
      json.model do
        json.id @quote.vehicle.model.id
        json.name @quote.vehicle.model.name
        json.brand do
          json.id @quote.vehicle.model.brand.id
          json.name @quote.vehicle.model.brand.name
        end
      end

      json.user do
        json.extract! @quote.vehicle.user, :id, :email, :first_name, :last_name, :dni, :birthdate,
                      :address, :phone_number, :is_active, :gender, :location_id
      end

      if @quote.vehicle.vehicle_images.attached?
        json.vehicle_images(@quote.vehicle.vehicle_images.map { |image| url_for(image) })
      else
        json.vehicle_images nil
      end

      json.model do
        if @quote.vehicle.model.present?
          json.extract! @quote.vehicle.model, :id, :name

          json.brand do
            if @quote.vehicle.model.brand.present? # rubocop:disable Metrics/BlockNesting
              json.extract! @quote.vehicle.model.brand, :id, :name
            end
          end
        end
      end
    end
  end
end
