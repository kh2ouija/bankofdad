class Account < ActiveRecord::Base

  belongs_to :customer

  validates_presence_of :balance, :currency
  validates_numericality_of :balance
  validate :balance_must_be_positive

  def self.default
    return Account.new do |a|
      a.balance = 0
      a.currency = 'lei'
    end
  end
  
  class InsufficientFunds < Exception; end;

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    if balance >= amount
      self.balance -= amount
    else
      raise InsufficientFunds
    end
  end
  
  protected
  def balance_must_be_positive
    errors.add(:balance, 'must be positive') if balance.nil? or balance < 0
  end

end
