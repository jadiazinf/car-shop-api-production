class Order < ApplicationRecord
  has_many :service_orders, class_name: 'ServiceOrder', dependent: :destroy
  has_many :services, through: :service_orders
  has_many :average_response_times, dependent: :nullify
  belongs_to :company, dependent: :destroy
  belongs_to :vehicle, optional: true
  belongs_to :created_by, class_name: 'UserCompany', optional: true
  belongs_to :assigned_to, class_name: 'UserCompany', optional: true
  has_one :user_order_review, dependent: :nullify

  def belongs_to_user?(user)
    vehicle.user_id == user.id
  end

  def belongs_to_company?(company)
    company_id == company.id
  end
end
