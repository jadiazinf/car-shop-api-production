class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :location_type, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
