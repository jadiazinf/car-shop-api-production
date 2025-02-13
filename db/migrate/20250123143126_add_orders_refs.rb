class AddOrdersRefs < ActiveRecord::Migration[7.1]
  def change
    add_reference :services_orders, :order, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
    add_reference :services_orders, :service, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
    add_reference :orders, :vehicle, foreign_key: { on_delete: :nullify }, null: false # rubocop:disable Rails/NotNullColumn
    add_reference :orders, :company, foreign_key: true
    add_reference :orders, :created_by, foreign_key: { to_table: :users_companies }, null: true
  end
end
