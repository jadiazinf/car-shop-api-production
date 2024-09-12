class AddReferencesToCompanyCreationRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :company_creation_requests, :company, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
    add_reference :company_creation_requests, :user, foreign_key: true, default: nil
    rename_column :company_creation_requests, :user_id, :responder_user_id
  end
end
