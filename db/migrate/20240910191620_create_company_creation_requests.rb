class CreateCompanyCreationRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :company_creation_requests do |t|
      t.string :status, default: 'pending', null: false
      t.string :message, null: true, default: nil
      t.timestamps
    end
  end
end
