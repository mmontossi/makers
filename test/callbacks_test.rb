require 'test_helper'

class CallbacksTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      before(:build) { |u| u.email = 'build@example.com' }
      after(:build) { |u| u.phone = 1 }
      before(:create) { |u| u.email = 'create@example.com' }
      after(:create) { |u| u.phone = 2 }
      fabricator :user do
        before(:build) { |u| u.name = 'build' }
        after(:build) { |u| u.age = 1 }
        before(:create) { |u| u.name = 'create' }
        after(:create) { |u| u.age = 2 }
      end
    end
  end
  
  test "build callbacks" do
    user = build(:user)
    assert_equal 'build@example.com', user.email
    assert_equal 1, user.phone
    assert_equal 'build', user.name
    assert_equal 1, user.age
  end
  
  test "create callbacks" do
    user = create(:user)
    assert_equal 'create@example.com', user.email
    assert_equal 2, user.phone
    assert_equal 'create', user.name
    assert_equal 2, user.age
  end

end
