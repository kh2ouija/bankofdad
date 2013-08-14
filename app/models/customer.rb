class Customer < ActiveRecord::Base

  has_many :transactions
  has_one :allowance

  validates_presence_of :name, :balance
  validate :balance_must_be_positive

  class InsufficientFunds < Exception; end;

  def record(transaction)
  	Customer.transaction do
      transaction.customer = self
      if transaction.operation == 'deposit'
        self.balance += transaction.amount
      elsif transaction.operation == 'withdraw'
        if self.balance >= transaction.amount     	
          self.balance -= transaction.amount
        else
          raise InsufficientFunds
        end
      end
      self.save!
      transaction.save!
  	end
  end

  protected
  def balance_must_be_positive
    errors.add(:balance, 'must be positive') if balance.nil? or balance < 0
  end
  
end