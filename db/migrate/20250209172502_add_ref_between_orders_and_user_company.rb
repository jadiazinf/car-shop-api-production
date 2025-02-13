class AddRefBetweenOrdersAndUserCompany < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :assigned_to, foreign_key: { to_table: :users_companies }, null: true
  end
end
