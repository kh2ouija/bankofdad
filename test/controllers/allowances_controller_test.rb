require 'test_helper'

class AllowancesControllerTest < ActionController::TestCase
  setup do
    sign_in :user, users(:one)
    @allowance = allowances(:one)
  end

  test "should get edit" do
    get :edit, customer_id: @allowance.customer, id: @allowance
    assert_response :success
  end

  test "should update allowance" do
    patch :update, customer_id: @allowance.customer, id: @allowance, allowance: { amount: @allowance.amount, customer_id: @allowance.customer_id, wday: @allowance.wday }
    assert_redirected_to @allowance.customer
  end

end
