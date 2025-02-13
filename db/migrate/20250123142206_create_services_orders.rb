class CreateServicesOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :services_orders do |t|
      t.numeric :cost, null: false, precision: 10, scale: 2
      t.string :status, null: false
      t.timestamps
    end
  end
end
