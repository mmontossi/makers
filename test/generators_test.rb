require 'test_helper'

class GeneratorsTest < ActiveSupport::TestCase
 
  setup do
    Fabricators.define do
      generator(:name) { 'name' }
      generator(:email) { |n| "mail#{n}@example.com" }
      generator(:age)
      fabricator :user do
        name
        age
        email
      end
    end
  end

  test "static generator" do
    assert_equal 'name', attributes_for(:user)[:name]
    assert_equal 'name', build(:user).name
    assert_equal 'name', create(:user).name
  end

  test "block generator" do
    assert_equal 'mail1@example.com', attributes_for(:user)[:email]
    assert_equal 'mail2@example.com', build(:user).email
    assert_equal 'mail3@example.com', create(:user).email
  end

  test "number generator" do
    assert_equal 1, attributes_for(:user)[:age]
    assert_equal 2, build(:user).age
    assert_equal 3, create(:user).age
  end
 
end
