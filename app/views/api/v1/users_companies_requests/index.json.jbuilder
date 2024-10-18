json.current_page @requests.current_page
json.next_page @requests.next_page
json.prev_page @requests.prev_page
json.total_pages @requests.total_pages
json.total_count @requests.total_count

json.data do
  json.array! @requests, :id, :status, :message, :created_at, :updated_at, :company_id
end
