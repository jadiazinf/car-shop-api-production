json.current_page @categories.current_page
json.next_page @categories.next_page
json.prev_page @categories.prev_page
json.total_pages @categories.total_pages
json.total_count @categories.total_count

json.data do
  json.array! @categories, :id, :name, :is_active, :created_at, :updated_at
end
