class AddRefToUsersCompaniesRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :users_companies_requests, :users_companies, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
    rename_column :users_companies_requests, :users_companies_id, :user_company_id
    add_reference :users_companies_requests, :users, null: true, foreign_key: true
    rename_column :users_companies_requests, :users_id, :responder_user_id
  end
end
