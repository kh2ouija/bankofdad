class TransactionsController < ApplicationController

  before_action :set_customer, only: [:index, :new, :create, :show]

  # GET /transactions
  def index
    @page_title = 'Transactions history'
    @transactions = @customer.transactions
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @page_title = 'New transaction'
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    begin
      @customer.record(@transaction)
      redirect_to customer_path(@customer), notice: 'Transaction was successfully created.'
    rescue Exception => e
      puts e
      @transaction.valid?
      @transaction.errors.add(:amount, 'exceeds available funds') if e.kind_of? Account::InsufficientFunds
      render action: 'new'
    end
  end
  
  private
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def transaction_params
      params.require(:transaction).permit(:operation, :amount, :description)
    end
end
