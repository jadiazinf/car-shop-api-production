class CreateUsersActivitiesLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :users_activities_logs do |t|
      t.string :event, null: false
      t.string :user_category, null: false
      t.references :user, null: true, foreign_key: true
      t.timestamps
    end
  end
end
