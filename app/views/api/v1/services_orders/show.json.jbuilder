if @service_order&.errors&.any?
  json.errors @service_order.errors.full_messages
else
  json.extract! @service_order, :id, :cost, :status, :created_at, :updated_at, :service_id,
                :service, :order, :order_id
end
