class AddPortionsToLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :portion1, :float
    add_column :loans, :portion2, :float
    add_column :loans, :portion3, :float
  end
end
