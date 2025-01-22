class CreateQuotes < ActiveRecord::Migration[7.1]
  def change
    create_table :quotes do |t|
      t.string :group_id, null: false
      t.numeric :total_cost, null: false, precision: 10, scale: 2
      t.date :date, null: false, default: -> { 'CURRENT_DATE' }
      t.string :note, null: true
      t.string :status_by_company, null: false
      t.string :status_by_client, null: false
      t.timestamps
    end
  end
end
