if @users_companies.present?
  json.current_page @users_companies.current_page
  json.next_page @users_companies.next_page
  json.prev_page @users_companies.prev_page
  json.total_pages @users_companies.total_pages
  json.total_count @users_companies.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do
  json.array! @users_companies, :id, :user_id, :company_id, :is_active, :created_at, :updated_at,
              :roles, :user
end
