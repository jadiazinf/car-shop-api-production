if @companies.present?
  json.current_page @companies.current_page
  json.next_page @companies.next_page
  json.prev_page @companies.prev_page
  json.total_pages @companies.total_pages
  json.total_count @companies.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do
  json.array! @companies do |company|
    json.id company.id
    json.name company.name
    json.dni company.dni
    json.email company.email
    json.number_of_employees company.number_of_employees
    json.payment_methods company.payment_methods
    json.social_networks company.social_networks
    json.phone_numbers company.phone_numbers
    json.address company.address
    json.is_active company.is_active
    json.location_id = company.location_id

    json.profile_image_url company.profile_image.attached? ? url_for(company.profile_image) : nil

    if company.company_images.attached?
      json.company_images(company.company_images.map do |image|
                            url_for(image)
                          end)
    end

    json.company_charter url_for(company.company_charter) if company.company_charter.attached?
  end
end
