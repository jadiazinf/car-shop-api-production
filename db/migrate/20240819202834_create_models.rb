class CreateModels < ActiveRecord::Migration[7.1]
  def change
    create_table :models do |t|
      t.string :name, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
