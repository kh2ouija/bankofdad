class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.integer :customer_id, null: false, options:
        "CONSTRAINT fk_allowance_customer REFERENCES customers(id)"
      t.string :interval, null: false
      t.decimal :amount, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
