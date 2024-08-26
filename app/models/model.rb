class Model < ApplicationRecord
  belongs_to :brand
  has_many :vehicles, dependent: :destroy
  ERRORS_KEY = 'active_record.errors.general'.freeze
  validates :name, presence: { message: I18n.t("#{ERRORS_KEY}.blank") }
end
