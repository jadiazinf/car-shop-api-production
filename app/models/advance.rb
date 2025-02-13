class Advance < ApplicationRecord
  belongs_to :service_order, optional: false
  has_many_attached :advance_images

  def belongs_to_user?(user)
    service_order.order.vehicle.user_id == user.id
  end

  def belongs_to_company?(company)
    service_order.order.company_id == company.id
  end
end
