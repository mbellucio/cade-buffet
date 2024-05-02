class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :company, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :event_pricing, null: false, foreign_key: true
      t.date :booking_date
      t.integer :predicted_guests
      t.string :event_details
      t.string :event_adress
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
