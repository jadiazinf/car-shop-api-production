json.current_page @companies.current_page
json.next_page @companies.next_page
json.prev_page @companies.prev_page
json.total_pages @companies.total_pages
json.total_count @companies.total_count
json.data do
  json.array! @companies do |company|
    json.extract! company, :id, :name, :dni, :is_active, :address, :phone_numbers, :created_at,
                  :updated_at
  end
end
