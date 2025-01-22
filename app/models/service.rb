class Service < ApplicationRecord
  belongs_to :category
  belongs_to :company
  has_many :quotes, dependent: :destroy
  validates :name, :description, presence: true
end
