class AddCustomerToLoan < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :customer, foreign_key: true
  end
end
