require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test 'positive total' do
    order = orders(:one)
    order.amount = -1
    assert_not order.valid?
  end
end
