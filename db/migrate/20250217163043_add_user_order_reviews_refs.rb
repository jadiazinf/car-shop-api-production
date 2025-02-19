class AddUserOrderReviewsRefs < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_order_reviews, :order, foreign_key: true
  end
end
