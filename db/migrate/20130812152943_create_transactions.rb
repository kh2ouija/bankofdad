class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.string :operation
      t.decimal :amount
      t.string :description

      t.timestamps
    end
  end
end
