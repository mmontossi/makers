require 'test_helper'

class CleanTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
      end
    end
    create :user, 5
    Fabricators.clean
  end

  test 'clean records' do
    assert_equal 0, User.count
  end

end
