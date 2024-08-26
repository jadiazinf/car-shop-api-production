class AddBrandReferenceToModel < ActiveRecord::Migration[7.1]
  def change
    add_reference :models, :brand, foreign_key: true
  end
end
