class Allowance < ActiveRecord::Base

  belongs_to :customer

  validates :customer_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :wday, numericality: { 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 6, 
    message: 'is not a valid day of the week'
  }

end
