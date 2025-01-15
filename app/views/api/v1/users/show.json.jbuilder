if @user&.errors&.any?
  json.errors @user.errors.full_messages
else
  json.extract! @user, :id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                :phone_number, :is_active, :gender, :location_id
end
