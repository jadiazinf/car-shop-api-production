class NotificationReceipt < ApplicationRecord
  self.table_name = 'notifications_receipts'
  belongs_to :notification
  belongs_to :user
end
