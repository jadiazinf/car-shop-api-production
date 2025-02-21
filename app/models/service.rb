class Service < ApplicationRecord
  belongs_to :category
  belongs_to :company
  has_many :service_orders, class_name: 'ServiceOrder', dependent: :destroy
  has_many :orders, through: :service_orders
  validates :name, :description, presence: true
end
