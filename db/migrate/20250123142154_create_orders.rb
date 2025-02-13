class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :status, null: false
      t.numeric :vehicle_mileage, null: false, precision: 10, scale: 2
      t.boolean :is_active, null: false, default: true
      t.boolean :is_checked, null: false, default: false
      t.timestamps
    end
  end
end
