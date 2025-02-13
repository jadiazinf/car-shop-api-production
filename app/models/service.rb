class Service < ApplicationRecord
  belongs_to :category
  belongs_to :company
  has_many :services_orders, dependent: :destroy
  has_many :orders, through: :services_orders
  validates :name, :description, presence: true
end
