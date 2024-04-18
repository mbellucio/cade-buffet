class AddComlumnsToBuffet < ActiveRecord::Migration[7.1]
  def change
    add_column :buffets, :email, :string
    add_column :buffets, :payment_method, :string
  end
end
