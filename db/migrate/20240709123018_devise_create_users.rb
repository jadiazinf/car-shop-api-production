# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: '',
                                    index: { unique: true, name: 'unique_user_email' }
      t.string :encrypted_password, null: false, default: ''
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :dni, null: false, index: { unique: true, name: 'unique_user_dni' }
      t.date :birthdate, null: false
      t.string :address
      t.string :phonenumber
      t.string :roles, array: true, default: []
      t.boolean :is_active, default: true, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end
  end
end
