class RemoveNullConstraintOnVehicleBodyAnEngineSerials < ActiveRecord::Migration[7.1]
  def change
    change_column_null :vehicles, :load_capacity, true
    change_column_null :vehicles, :engine_serial, true
    change_column_null :vehicles, :body_serial, true
  end
end
