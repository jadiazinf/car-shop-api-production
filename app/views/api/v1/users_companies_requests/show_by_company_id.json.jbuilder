json.current_page @company_creation_request.current_page
json.next_page @company_creation_request.next_page
json.prev_page @company_creation_request.prev_page
json.total_pages @company_creation_request.total_pages
json.total_count @company_creation_request.total_count

json.data do
  json.array! @company_creation_request, :id, :status, :message, :created_at, :updated_at,
              :company_id
end
