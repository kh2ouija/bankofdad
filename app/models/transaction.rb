class Transaction < ActiveRecord::Base
  
  belongs_to :customer

  validates :customer_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 } 
  validates :operation, inclusion: %w{ deposit withdraw }
  validates :description, presence: true

end
