class AddRefBetweenServicesAndCategories < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :category, foreign_key: true
  end
end
