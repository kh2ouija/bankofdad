class TransactionsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_customer, only: [:index, :new, :create, :show, :destroy]

  # GET /transactions
  def index
    @page_title = 'Transactions history'
    @transactions = @customer.transactions.order('created_at DESC')
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

  # DELETE /transactions/1
  def destroy
    @transaction = @customer.transactions.find(params[:id])
    begin
      @customer.undo(@transaction)
      redirect_to @customer
    rescue Exception => e
      puts e
    end
  end
  
  private
    def set_customer
      @customer = current_user.customers.find_by_name!(params[:customer_id])
    end

    def transaction_params
      params.require(:transaction).permit(:operation, :amount, :description)
    end
end
