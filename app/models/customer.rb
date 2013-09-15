class Customer < ActiveRecord::Base

  belongs_to :user
  has_one :account, dependent: :destroy  
  has_one :allowance, dependent: :destroy
  has_many :deposits

  validates :name, presence: true, uniqueness: true

  before_validation(on: :create) do
    self.name = name.capitalize if name?
  end

  def to_param
    name
  end

  def net_worth
    account.balance
  end
  
end