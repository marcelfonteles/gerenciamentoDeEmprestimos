class RemovePaymentFromLoan < ActiveRecord::Migration[5.2]
  def change
    remove_column :loans, :name, :string
    remove_column :loans, :firstPayment, :string
  end
end
