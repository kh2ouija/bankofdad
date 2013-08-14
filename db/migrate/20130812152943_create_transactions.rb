class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :customer_id, null: false, options: 
        "CONSTRAINT fk_transaction_customer REFERENCES customers(id)"
      t.string :operation, null: false
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.string :description, null: false

      t.timestamps
    end
  end
end
