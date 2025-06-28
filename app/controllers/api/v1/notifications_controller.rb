class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def unread_notifications
    @notifications = current_user.notifications.includes(:notification_receipts,
                                                         advance: [service_order: {
                                                           order: [:vehicle]
                                                         }]).page(params[:page])

    render :index, status: :ok
  end

  def read_notification
  #  actualizar notificacion
  NotificationReceipt.create(notification_id: params[:id])
  render json: { message: 'done' }, status: :ok
  end
end
