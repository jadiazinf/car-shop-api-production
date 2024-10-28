class CreateCompaniesServices < ActiveRecord::Migration[7.1]
  def change
    create_table :companies_services do |t|
      t.belongs_to :service, null: false, foreign_key: true
      t.belongs_to :company, null: true, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
