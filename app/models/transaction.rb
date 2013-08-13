class Transaction < ActiveRecord::Base
  
  validates_presence_of :operation, :amount, :description
  validates_numericality_of :amount
  validates_inclusion_of :operation, in: %w{ deposit withdraw }
  validate :amount_must_be_positive

  belongs_to :customer
  
  protected
  def amount_must_be_positive
    errors.add(:amount, 'must be at least 0.01') if amount.nil? or amount < 0.01
  end

end
