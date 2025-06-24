class RemoveUniquenessConstraintOnVehicle < ActiveRecord::Migration[7.1]
  def change
    remove_index :vehicles, name: 'unique_engine_serial'
    remove_index :vehicles, name: 'unique_body_serial'

    add_index :vehicles, :engine_serial
    add_index :vehicles, :body_serial

  end
end
