if @services.present?
  json.current_page @services.current_page
  json.next_page @services.next_page
  json.prev_page @services.prev_page
  json.total_pages @services.total_pages
  json.total_count @services.total_count
else
  json.current_page 0
  json.next_page false
  json.prev_page false
  json.total_pages 0
  json.total_count 0
end

json.data do
  json.array! @services do |service|
    json.id service.id
    json.name service.name
    json.description service.description
    json.price service[price_column]
    json.category service.category
    json.is_active service.is_active
    json.company_id service.company_id
    json.created_at service.created_at
    json.updated_at service.updated_at
  end
end
