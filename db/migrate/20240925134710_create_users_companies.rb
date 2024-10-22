class CreateUsersCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :users_companies do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true
      t.string :roles, array: true, default: ['admin']
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end

    add_index :users_companies, %i[user_id company_id], unique: true
  end
end
