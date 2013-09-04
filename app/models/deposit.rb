class Deposit < ActiveRecord::Base
  belongs_to :customer

  validates :customer_id, presence: true
  validates :duration_months, presence: true, numericality: true, inclusion: [1, 3, 6, 12]
  validates :interest, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :amount, presence: true, numericality: true

  before_create :set_term

  private 
    def set_term
      self.term = Date.today + duration_months.months
    end

end
