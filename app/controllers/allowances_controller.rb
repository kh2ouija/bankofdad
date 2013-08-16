class AllowancesController < ApplicationController
  
  before_action :set_customer, only: [:create, :edit, :update, :destroy]
  
  # GET /allowances/new
  def new
    @allowance = Allowance.new
  end

  # GET /allowances/1/edit
  def edit
    @allowance = @customer.allowance
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
    # Use callbacks to share common setup or constraints between actions.
    def set_allowance
      @allowance = Allowance.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowance_params
      params.require(:allowance).permit(:interval, :amount)
    end
end
