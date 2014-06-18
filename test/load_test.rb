require 'test_helper'

class LoadTest < ActiveSupport::TestCase

  setup do
    Fabricators.load_files
  end 

  test "find files" do
    assert build(:user)
  end

end
