class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price_for_motorbike, null: true, precision: 10, scale: 2
      t.decimal :price_for_car, null: true, precision: 10, scale: 2
      t.decimal :price_for_van, null: true, precision: 10, scale: 2
      t.decimal :price_for_truck, null: true, precision: 10, scale: 2
      t.boolean :is_active, null: false # rubocop:disable Rails/ThreeStateBooleanColumn
      t.timestamps
    end
  end
end
