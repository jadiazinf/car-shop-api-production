if @user_company&.errors&.any?
  json.errors @user_company.errors.full_messages
else
  json.extract! @user_company, :id, :user_id, :company_id, :is_active, :created_at, :updated_at,
                :roles
end
