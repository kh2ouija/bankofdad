class Customer < ActiveRecord::Base

  has_one :account, dependent: :destroy
  has_many :transactions
  has_one :allowance

  validates :name, presence: true

  def record(transaction)
  	Customer.transaction do
      transaction.customer = self
      if transaction.operation == 'deposit'
        account.deposit(transaction.amount)
      elsif transaction.operation == 'withdraw'
        account.withdraw(transaction.amount)
      end
      transaction.rbalance = account.balance
      account.save!
      transaction.save!
  	end
  end

  def net_worth
    account.balance
  end
  
end