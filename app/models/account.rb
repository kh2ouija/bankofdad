class Account < ActiveRecord::Base

  belongs_to :customer

  validates :currency, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :interest, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  
  class InsufficientFunds < Exception
  end

  def self.default
    Account.new do |a|
      a.balance = 0
      a.currency = 'lei'
      a.interest = 0
    end
  end

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    raise InsufficientFunds if balance < amount
    self.balance -= amount
  end
  
end
