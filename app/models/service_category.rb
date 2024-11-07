class Category < ApplicationRecord
  has_many :services, dependent: :nullify
  validates :name, :is_active, presence: true
end
