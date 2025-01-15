class AddUserReferenceToVehicle < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicles, :user, foreign_key: true, null: true
  end
end
