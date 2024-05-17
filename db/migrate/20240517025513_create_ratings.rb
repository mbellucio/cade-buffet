class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.integer :value
      t.string :feedback

      t.timestamps
    end
  end
end
