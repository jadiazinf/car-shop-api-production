class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :category, null: false
      t.timestamps
    end
  end
end
