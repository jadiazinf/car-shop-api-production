class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :service_type, null: false
      t.string :description, null: true, default: true
      t.timestamps
    end
  end
end
