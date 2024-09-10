class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :dni, null: false
      t.string :company_charter, null: false
      t.string :email, null: false
      t.integer :number_of_employees, null: false, default: 1
      t.string :payment_methods, array: true, default: [], null: false
      t.string :social_networks, array: true, default: [], null: false
      t.string :phonenumbers, array: true, default: [], null: false
      t.string :address, null: false
      t.string :request_status, null: false, default: 'pending'
      t.timestamps
    end
  end
end
