require 'test_helper'

class AliasesTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user, aliases: [:owner, :author] do
        name 'name'
        phone
      end
    end
  end

  test 'aliases' do
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:user)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:owner)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:author)
  end

end
