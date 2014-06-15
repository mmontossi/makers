require 'test_helper'

class MergesTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
      end
    end
  end
  
  test "return attributes" do
    assert_equal 'other', attributes_for(:user, name: 'other')[:name]
  end
 
  test "build instance" do
    assert_equal 'other', build(:user, name: 'other').name
  end
 
  test "create instance" do
    assert_equal 'other', create(:user, name: 'other').name
  end

end
