require 'test_helper'

class LoadTest < ActiveSupport::TestCase

  setup do
    Fabricators.populate
  end 

  test "find files" do
    assert build(:user)
  end

end
