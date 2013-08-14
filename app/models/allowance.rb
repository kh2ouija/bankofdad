class Allowance < ActiveRecord::Base

  belongs_to :customer

  validates_presence_of :customer_id, :interval, :amount
  validates_numericality_of :amount
  validate :amount_must_be_positive

  protected
  def amount_must_be_positive
    errors.add(:amount, 'must be at least 0.01') if amount.nil? or amount < 0.01
  end

end
