json.current_page @user_order_reviews.current_page
json.next_page @user_order_reviews.next_page
json.prev_page @user_order_reviews.prev_page
json.total_pages @user_order_reviews.total_pages
json.total_count @user_order_reviews.total_count

json.data do # rubocop:disable Metrics/BlockLength
  json.array! @user_order_reviews do |user_order_review| # rubocop:disable Metrics/BlockLength
    json.id user_order_review.id
    json.message user_order_review.message
    json.rating user_order_review.rating
    json.order_id user_order_review.order_id
    json.created_at user_order_review.created_at
    json.updated_at user_order_review.updated_at
    unless user_order_review.order.nil?
      json.order do
        json.id user_order_review.order.id
        json.created_by_id user_order_review.order.created_by_id
        json.assigned_to_id user_order_review.order.assigned_to_id
        json.created_at user_order_review.order.created_at
        json.updated_at user_order_review.order.updated_at
        json.status user_order_review.order.status
        if user_order_review.order.assigned_to
          json.assigned_to do
            json.id user_order_review.order.assigned_to.id
            json.user do
              json.id user_order_review.order.assigned_to.user.id
              json.first_name user_order_review.order.assigned_to.user.first_name
              json.last_name user_order_review.order.assigned_to.user.last_name
            end
          end
        end
      end
    end
  end
end
