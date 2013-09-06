class AllowancesController < ApplicationController
  
  before_filter :authenticate_user!
  before_action :set_customer, only: [:edit, :update]
  
  # GET /allowances/1/edit
  def edit
    @allowance = @customer.allowance
    @page_title = 'Modify allowance'
  end

  # PATCH/PUT /allowances/1
  def update
    if @customer.allowance.update(allowance_params)
      redirect_to @customer, notice: 'Allowance was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def set_customer
      @customer = current_user.customers.find_by_name!(params[:customer_id])
    end

    def allowance_params
      params.require(:allowance).permit(:wday, :amount)
    end
end
