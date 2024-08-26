class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.integer :year, null: false
      t.integer :axles, null: false
      t.integer :tires, null: false
      t.string :color, null: false, default: ''
      t.string :vehicle_type, null: false, default: ''
      t.integer :load_capacity, null: false, default: 0
      t.bigint :mileage, null: false, default: 1
      t.string :engine_serial, null: false, default: '',
                               index: { unique: true, name: 'unique_engine_serial' }
      t.string :body_serial, null: false, default: '',
                             index: { unique: true, name: 'unique_body_serial' }
      t.string :license_plate, null: false, default: '',
                               index: { unique: true, name: 'unique_license_plate' }
      t.string :engine_type, null: false, default: ''
      t.string :transmission, null: false, default: ''
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
