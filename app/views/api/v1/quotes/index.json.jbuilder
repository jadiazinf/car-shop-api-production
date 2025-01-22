if @quotes.present?
  json.current_page @quotes.current_page
  json.next_page @quotes.next_page
  json.prev_page @quotes.prev_page
  json.total_pages @quotes.total_pages
  json.total_count @quotes.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do # rubocop:disable Metrics/BlockLength
  json.array! @quotes do |quote| # rubocop:disable Metrics/BlockLength
    json.extract! quote, :id, :group_id, :total_cost, :date, :note, :status_by_company,
                  :status_by_client, :vehicle_id, :service_id, :created_at

    json.service do # rubocop:disable Metrics/BlockLength
      json.extract! quote.service, :id, :name, :description if quote.service.present?
      json.company do # rubocop:disable Metrics/BlockLength
        json.id quote.service.company.id
        json.name quote.service.company.name
        json.dni quote.service.company.dni
        json.email quote.service.company.email
        json.number_of_employees quote.service.company.number_of_employees
        json.payment_methods quote.service.company.payment_methods
        json.social_networks quote.service.company.social_networks
        json.phone_numbers quote.service.company.phone_numbers
        json.address quote.service.company.address
        json.is_active quote.service.company.is_active
        json.location_id quote.service.company.location_id

        if quote.service.company.profile_image.attached?
          json.profile_image_url url_for(quote.service.company.profile_image)
        else
          json.profile_image_url nil
        end

        if quote.service.company.company_images.attached?
          json.company_images(quote.service.company.company_images.map { |image| url_for(image) })
        else
          json.company_images nil
        end

        if quote.service.company.company_charter.attached?
          json.company_charter url_for(quote.service.company.company_charter)
        else
          json.company_charter nil
        end
      end
    end

    json.vehicle do
      if quote.vehicle.present?
        json.extract! quote.vehicle, :id, :license_plate, :user, :vehicle_type

        json.model do
          if quote.vehicle.model.present?
            json.extract! quote.vehicle.model, :id, :name

            json.brand do
              if quote.vehicle.model.brand.present?
                json.extract! quote.vehicle.model.brand, :id, :name
              end
            end
          end
        end
      end
    end
  end
end
