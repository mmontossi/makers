require 'test_helper'

class ListsTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
      end
    end
  end
  
  test "build list" do
    list = build(:user, 3)
    assert_equal 3, list.size
    list.each do |user|
      assert_kind_of User, user
      assert user.new_record?
      assert_equal 'name', user.name
    end
  end
 
  test "create list" do
    list = create(:user, 3)
    assert_equal 3, list.size
    list.each do |user|
      assert_kind_of User, user
      assert user.persisted?
      assert_equal 'name', user.name
    end
  end

end
