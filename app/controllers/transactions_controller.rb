class TransactionsController < ApplicationController

  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :new, :create, :show]

  # GET /transactions
  def index
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    begin
      @customer.record(@transaction)
      redirect_to customer_path(@customer, @transaction), notice: 'Transaction was successfully created.'
    rescue Exception => e
      puts e
      @transaction.valid?
      @transaction.errors.add(:amount, 'exceeds available funds') if e.kind_of? Account::InsufficientFunds
      render action: 'new'
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:operation, :amount, :description)
    end
end
