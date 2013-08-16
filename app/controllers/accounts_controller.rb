class AccountsController < ApplicationController

  before_action :set_customer

  # GET /customers/1/account/edit
  def edit
    @account = @customer.account
  end

  # PATCH /customers/1/account
  def update
    if @customer.account.update(account_params)
      redirect_to @customer, notice: 'Account settings successfully updated.'
    else
      render action: 'edit'
    end
  end

  protected
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:currency)
  end

end