class ServiceOrder < ApplicationRecord
  self.table_name = 'services_orders'
  belongs_to :order
  belongs_to :service

  def belongs_to_user?(user)
    order.vehicle.user_id == user.id
  end

  def belongs_to_company?(company)
    order.company_id == company.id
  end
end
