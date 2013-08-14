class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.decimal :balance, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
