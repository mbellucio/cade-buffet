class CreateEventPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_pricings do |t|
      t.references :pricing, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :base_price
      t.integer :extra_person_fee
      t.integer :extra_hour_fee

      t.timestamps
    end
  end
end
