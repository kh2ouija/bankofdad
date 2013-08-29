require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    sign_in :user, users(:one)
    @transaction = transactions(:one)
  end

  test "should get index" do
    get :index, customer_id: @transaction.customer
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "should get new" do
    get :new, customer_id: @transaction.customer
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, customer_id: @transaction.customer, transaction: { amount: @transaction.amount, customer_id: @transaction.customer, description: @transaction.description, operation: @transaction.operation, rbalance: 10.99 }
    end
    assert_redirected_to @transaction.customer
  end

end
