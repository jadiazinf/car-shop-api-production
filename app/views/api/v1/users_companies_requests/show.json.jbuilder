json.extract! @request, :id, :status, :message, :created_at, :updated_at

json.user do
  json.extract! @request.user_company.user, :id, :first_name, :last_name, :dni, :email,
                :phone_number, :birthdate, :gender, :address, :location_id
end

json.company do
  json.extract! @request.user_company.company, :id, :name, :location, :email, :address, :dni,
                :created_at, :updated_at
end
