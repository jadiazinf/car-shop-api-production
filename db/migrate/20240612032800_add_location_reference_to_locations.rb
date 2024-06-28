class AddLocationReferenceToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :locations, foreign_key: true, null: true
    rename_column :locations, :locations_id, :parent_location_id
  end
end
