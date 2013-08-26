require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, transaction: { amount: @transaction.amount, customer_id: @transaction.customer_id, description: @transaction.description, operation: @transaction.operation }
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

end
