class Account < ActiveRecord::Base

  belongs_to :customer

  validates_presence_of :balance, :currency
  validates_numericality_of :balance
  validate :balance_must_be_positive

  class InsufficientFunds < Exception
  end

  def self.default
    Account.new do |a|
      a.balance = 0
      a.currency = 'lei'
    end
  end

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    raise InsufficientFunds if balance < amount
    self.balance -= amount
  end
  
  protected
  def balance_must_be_positive
    errors.add(:balance, 'must be positive') if balance.nil? or balance < 0
  end

end
