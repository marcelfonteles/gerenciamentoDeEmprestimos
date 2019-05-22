class RemoveQtdPortionFromLoan < ActiveRecord::Migration[5.2]
  def change
    remove_column :loans, :qtyPortion, :string
  end
end
