json.current_page @notifications.current_page
json.next_page @notifications.next_page
json.prev_page @notifications.prev_page
json.total_pages @notifications.total_pages
json.total_count @notifications.total_count

json.data do
  json.array! @notifications do |notification|
    json.extract! notification, :id, :category, :advance_id, :created_at, :updated_at
    json.advance do
      json.extract! notification.advance, :id, :description, :service_order_id, :created_at,
                    :updated_at
      json.service_order do
        json.id notification.advance.service_order.id
        json.order_id notification.advance.service_order.order_id
        json.order do
          json.id notification.advance.service_order.order.id
          json.company_id notification.advance.service_order.order.company_id
        end
      end
    end
  end
end
