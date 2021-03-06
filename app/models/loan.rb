class Loan < ApplicationRecord
  # validates :amount,:store, :portion1, :portion2, :portion3, :date_p1, :date_p2, :date_p3, presence: true
  belongs_to :customer
  validates :amount, :portion1, :portion2, :portion3, :store, :date_p1, :date_p2, :date_p3, presence: true
end
