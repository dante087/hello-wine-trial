require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)

    @order_params = {
      order: {
        user_id: users(:one).id,
        amount: 30.99
      }
    }
  end

  test 'should show orders' do
    get api_v1_orders_url, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal orders.count, json_response.count
  end

  test 'should show order' do
    get api_v1_order_url(@order), as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @order.amount.to_s, json_response['amount']
  end

  test 'should create order' do
    assert_difference('Order.count', 1) do
      post api_v1_orders_url, params: @order_params, as: :json
    end

    assert_response :created
  end
end
