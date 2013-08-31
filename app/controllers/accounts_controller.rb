class AccountsController < ApplicationController

  before_filter :authenticate_user!

  # GET /customers/1/account/edit
  def edit
    @page_title = 'Account settings'
    @account = current_user.customers.find_by_name(params[:id]).account
  end

  # PATCH /customers/1/account
  def update
    @account = current_user.customers.find(params[:id]).account
    if @account.update(account_params)
      redirect_to @account.customer, notice: 'Account settings successfully updated.'
    else
      render action: 'edit'
    end
  end

protected
  def account_params
    params.require(:account).permit(:currency, :interest)
  end

end