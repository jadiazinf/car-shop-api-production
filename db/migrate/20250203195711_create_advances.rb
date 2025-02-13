class CreateAdvances < ActiveRecord::Migration[7.1]
  def change
    create_table :advances do |t|
      t.string :description, null: false
      t.timestamps
    end
  end
end
