class DepositsController < ApplicationController
  before_action :set_customer, only: [:new, :create]
  before_action :set_deposit, only: [:destroy]

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # POST /deposits
  def create
    @deposit = Deposit.new(deposit_params)
    @deposit.customer = @customer
    begin
      transaction = Transaction.new do |t|
        t.operation = 'withdraw'
        t.amount = @deposit.amount
        t.description = 'Creating term deposit'
      end
      Deposit.transaction do
        @customer.record(transaction)
        @deposit.save!
      end
      redirect_to @customer, notice: 'Deposit was successfully created.'
    rescue Exception => e
      puts e
      @deposit.valid?
      @deposit.errors.add(:amount, 'exceeds available funds') if e.kind_of? Account::InsufficientFunds
      render action: 'new'
    end
  end

  # DELETE /deposits/1
  def destroy
    begin
      transaction = Transaction.new do |t|
        t.operation = 'deposit'
        t.amount = @deposit.amount
        t.description = 'Early canceling term deposit'
      end
      Deposit.transaction do
        @deposit.customer.record(transaction)
        @deposit.destroy!
      end      
    rescue Exception => e
      puts e
    end  
    redirect_to @deposit.customer  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    def set_customer
      @customer = current_user.customers.find_by_name!(params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:duration_months, :interest, :amount)
    end
end
