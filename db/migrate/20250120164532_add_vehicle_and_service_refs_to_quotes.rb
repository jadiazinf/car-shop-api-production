class AddVehicleAndServiceRefsToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :quotes, :vehicle, foreign_key: true
    add_reference :quotes, :service, foreign_key: true
  end
end
