class AccountsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_account

  # GET /customers/1/account/edit
  def edit
    @page_title = 'Account settings'
  end

  # PATCH /customers/1/account
  def update
    if @account.update(account_params)
      redirect_to @account.customer, notice: 'Account settings successfully updated.'
    else
      render action: 'edit'
    end
  end

  protected
  def set_account
    @account = current_user.customers.find_by_name!(params[:id]).account
  end

  def account_params
    params.require(:account).permit(:currency, :interest)
  end

end