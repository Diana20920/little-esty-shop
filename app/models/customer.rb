class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.five_top_customers_by_transactions
    Customer.joins(invoices: :transactions)
    .where('result = ?', "success")
    .select("customers.*, count('transactions.result') AS successful_transactions")
    .group("customers.id")
    .order(successful_transactions: :desc)
    .limit(5)
  end
end
