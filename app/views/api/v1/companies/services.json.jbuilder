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
  json.array! @services, :id, :name, :price_for_motorbike, :price_for_car, :price_for_van,
              :price_for_truck, :category, :description, :is_active, :company_id, :created_at,
              :updated_at
end
