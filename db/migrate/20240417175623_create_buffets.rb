class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :company_name
      t.string :phone_number
      t.string :zip_code
      t.string :adress
      t.string :neighborhood
      t.string :city
      t.string :state_code
      t.string :description
      t.belongs_to :company, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
