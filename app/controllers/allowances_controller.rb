class AllowancesController < ApplicationController
  
  before_action :set_customer, only: [:new, :create, :edit, :update, :destroy]
  
  # GET /allowances/new
  def new
    @allowance = Allowance.new
    @page_title = 'Setup allowance'
  end

  # GET /allowances/1/edit
  def edit
    @allowance = @customer.allowance
    @page_title = 'Modify allowance'
  end

  # POST /allowances
  def create
    @allowance = Allowance.new(allowance_params)
    @allowance.customer = @customer
    if @allowance.save
      redirect_to @customer, notice: 'Allowance was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /allowances/1
  def update
    @allowance = @customer.allowance
    if @customer.allowance.update(allowance_params)
      redirect_to @customer, notice: 'Allowance was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /allowances/1
  def destroy
    @customer.allowance.destroy
    redirect_to @customer
  end

  private
    def set_allowance
      @allowance = Allowance.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def allowance_params
      params.require(:allowance).permit(:wday, :amount)
    end
end
