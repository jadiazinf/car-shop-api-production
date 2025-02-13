class AddRefToAdvances < ActiveRecord::Migration[7.1]
  def change
    add_reference :advances, :services_order, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
    rename_column :advances, :services_order_id, :service_order_id
  end
end
