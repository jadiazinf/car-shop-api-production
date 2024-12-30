if @users_company.present?
  json.current_page @users_company.current_page
  json.next_page @users_company.next_page
  json.prev_page @users_company.prev_page
  json.total_pages @users_company.total_pages
  json.total_count @users_company.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do
  json.array! @users_company do |user_company|
    json.id user_company[:id]
    json.company_id user_company[:company_id]
    json.user_id user_company[:user_id]
    json.user do
      json.id user_company[:user][:id]
      json.first_name user_company[:user][:first_name]
      json.last_name user_company[:user][:last_name]
      json.dni user_company[:user][:dni]
      json.gender user_company[:user][:gender]
      json.email user_company[:user][:email]
      json.birthdate user_company[:user][:birthdate]
      json.address user_company[:user][:address]
      json.phone_number user_company[:user][:phone_number]
    end
    json.roles user_company[:roles]
    json.is_active user_company[:is_active]
  end
end
