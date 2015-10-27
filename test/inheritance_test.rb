require 'test_helper'

class InheritanceTest < ActiveSupport::TestCase

  setup do
    Makers.define do
      maker :user do
        name 'name'
        maker :user_with_age do
          age 9
        end
      end
      maker :user_with_email, parent: :user do
        email 'mail@example.com'
      end
    end
  end

  test 'return attributes' do
    user_with_age = attributes_for(:user_with_age)
    assert_equal 'name', user_with_age[:name]
    assert_equal 9, user_with_age[:age]

    user_with_email = attributes_for(:user_with_email)
    assert_equal 'name', user_with_email[:name]
    assert_equal 'mail@example.com', user_with_email[:email]
  end

  test 'build instance' do
    user_with_age = build(:user_with_age)
    assert_equal 'name', user_with_age.name
    assert_equal 9, user_with_age.age

    user_with_email = build(:user_with_email)
    assert_equal 'name', user_with_email.name
    assert_equal 'mail@example.com', user_with_email.email
  end

  test 'create instance' do
    user_with_age = create(:user_with_age)
    assert_equal 'name', user_with_age.name
    assert_equal 9, user_with_age.age

    user_with_email = create(:user_with_email)
    assert_equal 'name', user_with_email.name
    assert_equal 'mail@example.com', user_with_email.email
  end

end
