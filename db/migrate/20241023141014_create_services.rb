class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.boolean :is_active, null: false # rubocop:disable Rails/ThreeStateBooleanColumn
      t.timestamps
    end
  end
end
