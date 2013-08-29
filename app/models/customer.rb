class Customer < ActiveRecord::Base

  belongs_to :user
  has_one :account, dependent: :destroy
  has_many :transactions
  has_one :allowance

  validates :name, presence: true, uniqueness: true

  before_validation(on: :create) do
    self.name = name.capitalize if name?
  end

  def to_param
    name
  end

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