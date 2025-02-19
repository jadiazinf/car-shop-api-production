class CreateUserOrderReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :user_order_reviews do |t|
      t.string :message, null: true
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
