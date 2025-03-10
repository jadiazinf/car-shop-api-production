class AverageResponseTime < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :order
end
