class AddNotificationsRefs < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :advance, foreign_key: true
    add_reference :notifications_receipts, :notification, foreign_key: true
    add_reference :notifications_receipts, :user, foreign_key: true
    add_reference :notifications, :user, foreign_key: true
  end
end
