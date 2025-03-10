class CreateAverageResponseTime < ActiveRecord::Migration[7.1]
  def change
    create_table :average_response_times do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
