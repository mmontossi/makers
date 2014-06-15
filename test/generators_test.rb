require 'test_helper'

class GeneratorsTest < ActiveSupport::TestCase
 
  setup do
    Fabricators.define do
      generator(:age)
      generator(:email) { |n| "mail#{n}@example.com" }
      fabricator :user do
        age
        email
      end
    end
  end

  test "number generator" do
    assert_equal 1, generate(:age)
    5.times { generate(:age) }
    assert_equal 7, generate(:age)
    assert_equal 8, attributes_for(:user)[:age]
    assert_equal 9, build(:user).age
    assert_equal 10, create(:user).age
  end

  test "block generator" do
    assert_equal "mail1@example.com", generate(:email)
    5.times { generate(:email) }
    assert_equal "mail7@example.com", generate(:email)
    assert_equal "mail8@example.com", attributes_for(:user)[:email]
    assert_equal "mail9@example.com", build(:user).email
    assert_equal "mail10@example.com", create(:user).email
  end
 
end
