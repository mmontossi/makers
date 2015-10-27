require 'test_helper'

class CleanTest < ActiveSupport::TestCase

  setup do
    Makers.define do
      maker :user do
      end
    end
    create :user, 5
    Makers.clean
  end

  test 'clean records' do
    assert_equal 0, User.count
  end

end
