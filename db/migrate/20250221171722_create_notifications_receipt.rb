class CreateNotificationsReceipt < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications_receipts, &:timestamps
  end
end
