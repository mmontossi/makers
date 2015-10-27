require 'test_helper'

class LoadTest < ActiveSupport::TestCase

  setup do
    Makers.load
  end 

  test 'find files' do
    assert build(:user)
  end

end
