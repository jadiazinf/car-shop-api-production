class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :dni, null: false, index: { unique: true, name: 'unique_company_dni' }
      t.string :email, null: false, index: { unique: true, name: 'unique_company_email' }
      t.integer :number_of_employees, null: false, default: 0
      t.string :payment_methods, array: true, default: [], null: false
      t.string :social_networks, array: true, default: [], null: false
      t.string :phone_numbers, array: true, default: [], null: false
      t.string :address, null: false
      t.boolean :is_active, null: false, default: false
      t.timestamps
    end
  end
end
