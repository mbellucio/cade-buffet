class RemovePaymentMethodFromBuffets < ActiveRecord::Migration[7.1]
  def change
    remove_column :buffets, :payment_method, :string
  end
end
