require 'test_helper'

class AllowancesControllerTest < ActionController::TestCase
  setup do
    @allowance = allowances(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allowance" do
    assert_difference('Allowance.count') do
      post :create, allowance: { amount: @allowance.amount, customer_id: @allowance.customer_id, wday: @allowance.wday }
    end

    assert_redirected_to allowance_path(assigns(:allowance))
  end

  test "should get edit" do
    get :edit, id: @allowance
    assert_response :success
  end

  test "should update allowance" do
    patch :update, id: @allowance, allowance: { amount: @allowance.amount, customer_id: @allowance.customer_id, wday: @allowance.wday }
    assert_redirected_to allowance_path(assigns(:allowance))
  end

  test "should destroy allowance" do
    assert_difference('Allowance.count', -1) do
      delete :destroy, id: @allowance
    end

    assert_redirected_to allowances_path
  end
end
