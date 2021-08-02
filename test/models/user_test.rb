require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should create user with valid data' do
    user = User.new(email: 'email.1@example.org', name: 'user1')
    assert user.valid?
  end

  test 'user with invalid data should be invalid' do
    user = User.new(email: 'email', name: 'user2')
    assert_not user.valid?
  end

  test 'user with email taken should be invalid' do
    user_one = users(:one)
    user = User.new(email: user_one.email, name: 'user2')
    assert_not user.valid?
  end
end
