class AddModelReferenceToVehicle < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicles, :model, foreign_key: true
  end
end
