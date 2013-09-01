class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.integer :customer_id, null: false, options:
        "CONSTRAINT fk_deposit_customer REFERENCES customers(id)"
      t.integer :duration_months, null: false
      t.integer :interest, null: false 
      t.decimal :balance, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
