require 'test_helper'

class AllowancesControllerTest < ActionController::TestCase
  setup do
    @allowance = allowances(:one)
  end

  test "should get new" do
    get :new, customer_id: @allowance.customer_id
    assert_response :success
  end

  test "should create allowance" do
    assert_difference('Allowance.count') do
      post :create, customer_id: @allowance.customer_id, allowance: { amount: @allowance.amount, customer_id: @allowance.customer_id, wday: @allowance.wday }
    end

    assert_redirected_to @allowance.customer
  end

  test "should get edit" do
    get :edit, customer_id: @allowance.customer_id, id: @allowance
    assert_response :success
  end

  test "should update allowance" do
    patch :update, customer_id: @allowance.customer_id, id: @allowance, allowance: { amount: @allowance.amount, customer_id: @allowance.customer_id, wday: @allowance.wday }
    assert_redirected_to @allowance.customer
  end

  test "should destroy allowance" do
    assert_difference('Allowance.count', -1) do
      delete :destroy, customer_id: @allowance.customer_id, id: @allowance
    end

    assert_redirected_to @allowance.customer
  end
end
