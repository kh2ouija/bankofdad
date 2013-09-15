class Transaction < ActiveRecord::Base
  
  belongs_to :account

  validates :account_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 } 
  validates :operation, inclusion: %w{ deposit withdraw }
  validates :description, presence: true

  before_create do
    self.rbalance = account.balance
  end

  def customer
    self.account.customer
  end

end
