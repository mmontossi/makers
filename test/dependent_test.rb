require 'test_helper'

class DependentTest < ActiveSupport::TestCase

  setup do
    Makers.define do
      maker :user do
        email { "#{name}@example.com" }
        sequence(:username) { |n| "#{name}-#{n}" }
        name 'name'
      end
    end
  end

  test 'return attributes' do
    assert_equal 'name-1', attributes_for(:user)[:username]
    assert_equal 'name@example.com', attributes_for(:user)[:email]
  end

  test 'build instance' do
    assert_equal 'name-1', build(:user).username
    assert_equal 'name@example.com', build(:user).email
  end

  test 'create instance' do
    assert_equal 'name-1', create(:user).username
    assert_equal 'name@example.com', create(:user).email
  end

end
