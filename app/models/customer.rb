class Customer < ActiveRecord::Base

  belongs_to :user
  has_one :account, dependent: :destroy  
  has_one :allowance, dependent: :destroy
  has_many :transactions
  has_many :deposits

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
      account.apply(transaction)
      transaction.rbalance = account.balance
      account.save!
      transaction.save!
  	end
  end

  def undo(transaction)
    Customer.transaction do
      account.undo(transaction)
      account.save!
      transaction.destroy!
    end
  end

  def net_worth
    account.balance
  end
  
end