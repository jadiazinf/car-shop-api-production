class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.boolean :is_active, null: false # rubocop:disable Rails/ThreeStateBooleanColumn
      t.timestamps
    end
  end
end
