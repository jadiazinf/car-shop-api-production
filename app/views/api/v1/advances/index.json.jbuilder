json.array! @advances do |advance|
  json.extract! advance, :id, :description, :service_order_id, :created_at, :updated_at
  if advance.advance_images.attached?
    json.advance_images(advance.advance_images.map do |image|
                          url_for(image)
                        end)
  else
    json.advance_images([])
  end
end
