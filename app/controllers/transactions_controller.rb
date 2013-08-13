class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :new, :create, :show]

  # GET /transactions
  def index
  end

  # GET /transactions/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.customer = @customer
    ActiveRecord::Base.transaction do
      unless @transaction.amount.nil?
        if @transaction.operation == 'deposit'
          @customer.balance += @transaction.amount
        elsif @transaction.operation == 'withdraw'
          @customer.balance -= @transaction.amount
        end
      end
      @customer.save!
      @transaction.save!
      redirect_to customer_path(@customer, @transaction), notice: 'Transaction was successfully created.'
    end
  rescue ActiveRecord::RecordInvalid => e
    @transaction.valid?
    if @customer.balance < 0
      @transaction.errors.add(:amount, 'insufficient funds')
    end
    render action: 'new'
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
    redirect_to transactions_url
  end

  def validate
    errors.add(:amount, 'insufficient funds') if operation == 'withdraw' and customer.balance == 0
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
      params.require(:transaction).permit(:customer_id, :operation, :amount, :description)
    end
end
