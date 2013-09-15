class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false, options: 
        "CONSTRAINT fk_transaction_account REFERENCES accounts(id)"
      t.string :operation, null: false
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.decimal :rbalance, null: false, precision: 8, scale: 2
      t.string :description, null: false

      t.timestamps
    end
  end
end
