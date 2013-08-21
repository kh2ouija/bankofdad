class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :customer_id, null: false
      t.decimal :balance, null: false, precision: 8, scale: 2
      t.string :currency, null: false
      t.integer :interest

      t.timestamps
    end
  end
end
