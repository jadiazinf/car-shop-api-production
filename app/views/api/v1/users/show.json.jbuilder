if @user&.errors&.any?
  json.errors @user.errors.full_messages
else
  json.extract! @user, :id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                :phonenumber, :roles, :is_active
end
