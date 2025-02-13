class Order < ApplicationRecord
  has_many :services_orders, class_name: 'ServiceOrder', dependent: :destroy
  has_many :services, through: :services_orders
  belongs_to :company, dependent: :destroy
  belongs_to :vehicle, optional: true
  # belongs_to :user_company, optional: true
  # belongs_to :user_company, foreign_key: 'assigned_to', optional: true, inverse_of: :service_orders

  belongs_to :created_by, class_name: 'UserCompany', optional: true
  belongs_to :assigned_to, class_name: 'UserCompany', optional: true

  def belongs_to_user?(user)
    vehicle.user_id == user.id
  end

  def belongs_to_company?(company)
    company_id == company.id
  end
end
