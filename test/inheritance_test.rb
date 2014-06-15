require 'test_helper'

class InheritanceTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
        fabricator :other_user do
          name 'other'
        end
      end
    end
  end

  test "return attributes" do
    assert_equal 'other', attributes_for(:other_user)[:name]
  end

  test "build instance" do
    assert_equal 'other', build(:other_user).name
  end

  test "create instance" do
    assert_equal 'other', create(:other_user).name
  end

end
