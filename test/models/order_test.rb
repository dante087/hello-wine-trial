require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test 'should be positive total' do
    order = orders(:one)
    order.amount = -1
    assert_not order.valid?
  end

  test 'should not create order with invalid data' do
    order = Order.new(amount: 29.99)
    assert_not order.valid?
  end

  test 'should set delivery_date on status change' do
    order = orders(:two)
    order.status = :delivered
    order.save
    assert_not_nil order.delivery_date
  end

  test 'should set payment_date on payment_status change' do
    order = orders(:two)
    order.payment_status = :paid
    order.save
    assert_not_nil order.payment_date
  end
end
