class CreateJwtDenylist < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false, index: { unique: true, name: 'unique_jti' }
      t.datetime :exp, null: false
      t.timestamps
    end
    add_index :jwt_denylist, :jti
  end
end
