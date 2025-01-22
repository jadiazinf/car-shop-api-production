json.extract! @request, :id, :status, :message, :created_at, :updated_at

json.user do
  json.extract! @request.user_company.user, :id, :first_name, :last_name, :dni, :email,
                :phone_number, :birthdate, :gender, :address, :location_id
end

json.company do
  json.extract! @request.user_company.company, :id, :name, :location, :email, :address, :dni,
                :created_at, :updated_at

  if @request.user_company.company.company_images.attached?
    json.company_images(@request.user_company.company.company_images.map do |image|
                          url_for(image)
                        end)
  else
    json.company_images([])
  end

  if @request.user_company.company.company_charter.attached?
    json.company_charter url_for(@request.user_company.company.company_charter)
  else
    json.company_charter nil
  end
end
