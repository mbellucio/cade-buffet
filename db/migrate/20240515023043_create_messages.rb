class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :order, null: false, foreign_key: true
      t.integer :user_id
      t.string :user_type

      t.timestamps
    end
  end
end
