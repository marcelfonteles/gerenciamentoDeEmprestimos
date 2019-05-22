class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.float :amount
      t.date :firstPayment
      t.string :name
      t.string :store
      t.integer :qtyPortion

      t.timestamps
    end
  end
end
