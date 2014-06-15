require 'test_helper'

class DependentTest < ActiveSupport::TestCase
 
  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
        email { "#{name}@example.com" }
      end
    end
  end
 
  test "return attributes" do
    assert_equal 'name@example.com', attributes_for(:user)[:email]
  end
 
  test "build instance" do
    assert_equal 'name@example.com', build(:user).email
  end
 
  test "create instance" do
    assert_equal 'name@example.com', create(:user).email
  end

end
