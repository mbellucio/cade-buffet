class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :min_quorum
      t.integer :max_quorum
      t.integer :standard_duration
      t.string :menu
      t.boolean :serve_alcohol
      t.boolean :handle_decoration
      t.boolean :valet_service
      t.boolean :flexible_location
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
