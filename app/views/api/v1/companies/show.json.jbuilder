if @company&.errors&.any?
  json.errors @company.errors.full_messages
else
  json.id @company.id
  json.name @company.name
  json.dni @company.dni
  json.email @company.email
  json.number_of_employees @company.number_of_employees
  json.payment_methods @company.payment_methods
  json.social_networks @company.social_networks
  json.phone_numbers @company.phone_numbers
  json.address @company.address
  json.is_active @company.is_active
  json.location_id @company.location_id

  if @company.profile_image.attached?
    json.profile_image_url url_for(@company.profile_image)
  else
    json.profile_image_url nil
  end

  if @company.company_images.attached?
    json.company_images(@company.company_images.map { |image| url_for(image) })
  else
    json.company_images nil
  end

  if @company.company_charter.attached?
    json.company_charter url_for(@company.company_charter)
  else
    json.company_charter nil
  end
end
