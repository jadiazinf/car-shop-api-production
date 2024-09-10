class AddLocationReferenceToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_reference :companies, :location, foreign_key: true
  end
end
