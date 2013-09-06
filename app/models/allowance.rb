class Allowance < ActiveRecord::Base

  belongs_to :customer

  validates :amount, numericality: true
  validates :wday, numericality: { 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 6, 
    message: 'is not a valid day of the week'
  }

  def self.default
    Allowance.new do |a|
      a.amount = 0
      a.wday = 0
    end
  end

end
