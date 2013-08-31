class CustomersController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :settings]

  # GET /customers
  def index
    @customers = current_user.customers
  end

  # GET /customers/1
  def show
    @recent_transactions = Transaction.where(customer: @customer).order('created_at DESC').limit(3)
    @last_transaction = @recent_transactions.first 
    if @customer.account.interest > 0
      @next_interest_date = Date.today + (6 - Date.today.wday)  
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @page_title = 'New customer'
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    account = Account.default
    account.customer = @customer
    begin
      Customer.transaction do
        @customer.save!
        account.save!
        redirect_to @customer, notice: 'Customer was successfully created.'
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
    redirect_to customers_url
  end

  private
    def set_customer
      @customer = current_user.customers.find_by_name!(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name)
    end
end
