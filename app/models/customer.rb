class Customer < ActiveRecord::Base

  validates_presence_of :name, :balance
  validate :balance_must_be_positive

  has_many :transactions

  protected
  def balance_must_be_positive
    errors.add(:balance, 'must be positive') if balance.nil? or balance < 0
  end
  
end