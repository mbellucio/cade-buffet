class CreatePricings < ActiveRecord::Migration[7.1]
  def change
    create_table :pricings do |t|
      t.string :category

      t.timestamps
    end
  end
end
