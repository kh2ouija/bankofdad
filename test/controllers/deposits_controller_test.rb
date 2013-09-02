require 'test_helper'

class DepositsControllerTest < ActionController::TestCase
  setup do
    sign_in :user, users(:one)
    @deposit = deposits(:one)
  end

  test "should get new" do
    get :new, customer_id: @deposit.customer
    assert_response :success
  end

  test "should create deposit" do
    assert_difference('Deposit.count') do
      post :create, customer_id: @deposit.customer, deposit: { balance: @deposit.balance, customer: @deposit.customer, duration_months: @deposit.duration_months, interest: @deposit.interest }
    end

    assert_redirected_to @deposit.customer
  end

  test "should destroy deposit" do
    assert_difference('Deposit.count', -1) do
      delete :destroy, customer_id: @deposit.customer, id: @deposit
    end

    assert_redirected_to @deposit.customer
  end
end
