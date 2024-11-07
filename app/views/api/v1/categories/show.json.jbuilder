if @category&.errors&.any?
  json.errors @category.errors.full_messages
else
  json.extract! @category, :id, :name, :is_active
end
