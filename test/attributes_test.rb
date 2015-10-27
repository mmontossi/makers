require 'test_helper'

class AttributesTest < ActiveSupport::TestCase

  setup do
    Makers.define do
      maker :user do
        sequence(:email) { |n| "mail#{n}@example.com" }
        sequence(:age)
      end
    end
  end

  test 'block sequence' do
    assert_equal 'mail1@example.com', attributes_for(:user)[:email]
    assert_equal 'mail2@example.com', build(:user).email
    assert_equal 'mail3@example.com', create(:user).email
  end

  test 'numeric sequence' do
    assert_equal 1, attributes_for(:user)[:age]
    assert_equal 2, build(:user).age
    assert_equal 3, create(:user).age
  end

end
