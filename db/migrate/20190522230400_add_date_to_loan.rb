class AddDateToLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :date_p1, :date
    add_column :loans, :date_p2, :date
    add_column :loans, :date_p3, :date
  end
end
