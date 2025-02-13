json.current_page @services_orders.current_page
json.next_page @services_orders.next_page
json.prev_page @services_orders.prev_page
json.total_pages @services_orders.total_pages
json.total_count @services_orders.total_count

json.data do
  json.array! @services_orders, :id, :cost, :status, :created_at, :updated_at, :service_id,
              :service, :order, :order_id
end
