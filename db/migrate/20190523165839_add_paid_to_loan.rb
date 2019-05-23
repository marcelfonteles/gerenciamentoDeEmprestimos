class AddPaidToLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :paid_p1, :boolean
    add_column :loans, :paid_p2, :boolean
    add_column :loans, :paid_p3, :boolean
  end
end
