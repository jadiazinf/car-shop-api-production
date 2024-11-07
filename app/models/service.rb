class Service < ApplicationRecord
  belongs_to :category
  belongs_to :company
  validates :name, :description, :price, presence: true
end
