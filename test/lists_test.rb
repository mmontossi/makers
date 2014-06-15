require 'test_helper'

class ListsTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
        age 9
      end
    end
  end
  
  test "build list" do
    list = build(:user, 3, name: 'other')
    assert_equal 3, list.size
    list.each do |user|
      assert_kind_of User, user
      assert_equal 'other', user.name
      assert_equal 9, user.age
    end
  end
 
  test "create list" do
    list = create(:user, 3, name: 'other')
    assert_equal 3, list.size
    list.each do |user|
      assert_kind_of User, user
      assert_equal 'other', user.name
      assert_equal 9, user.age
    end
  end

end
