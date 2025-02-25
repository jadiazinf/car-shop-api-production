class Notifications::CreateByAdvance
  attr_accessor :user_id, :advance

  def initialize(advance_id)
    @advance = Advance.find(advance_id)
    @user_id = @advance.service_order.order.vehicle.user_id
  end

  def perform
    notification = Notification.create(category: 'advance', advance_id: @advance.id, user_id:)
    return false unless notification.save

    notification_receipt = NotificationReceipt.create(notification_id: notification.id,
                                                      user_id:)
    return true if notification_receipt.save

    false
  end
end
