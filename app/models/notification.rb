class Notification < ApplicationRecord
  belongs_to :advance
  has_many :notification_receipts, dependent: :destroy
  belongs_to :user
end
