class CreateUserReferrals < ActiveRecord::Migration[7.1]
  def change
    create_table :user_referrals do |t|
      t.string :referral_by, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
