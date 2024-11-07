class AddRefBetweenCompanyAndServices < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :company, foreign_key: true
  end
end
