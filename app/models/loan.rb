class Loan < ApplicationRecord
  validates :amount, :name, :store, :portion1, :portion2, :portion3, :date_p1, :date_p2, :date_p3, presence: true
end
