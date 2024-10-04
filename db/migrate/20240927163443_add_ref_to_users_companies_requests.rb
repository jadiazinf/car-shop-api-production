class AddRefToUsersCompaniesRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :users_companies_requests, :users_companies, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
