class AddLocationReferenceToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :location, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
