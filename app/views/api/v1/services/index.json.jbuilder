json.current_page @services.current_page
json.next_page @services.next_page
json.prev_page @services.prev_page
json.total_pages @services.total_pages
json.total_count @services.total_count

json.data do
  json.array! @services, :id, :name, :category, :price_for_motorbike, :price_for_car,
              :price_for_van, :price_for_truck, :is_active, :description, :created_at, :updated_at
end
