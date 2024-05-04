class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :order, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.integer :base_price, default: 0
      t.integer :additional_cost, default: 0
      t.string :additional_cost_describe
      t.integer :discount, default: 0
      t.string :discount_describe
      t.date :proposal_deadline
      t.integer :final_price, default: 0

      t.timestamps
    end
  end
end
