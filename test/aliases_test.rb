require 'test_helper'

class AliasesTest < ActiveSupport::TestCase

  setup do
    Makers.define do
      maker :user, aliases: [:owner, :author] do
        name 'name'
        phone
      end
    end
  end

  test 'aliases' do
    assert_kind_of Makers::Maker, Makers.definitions.find(:user)
    assert_kind_of Makers::Maker, Makers.definitions.find(:owner)
    assert_kind_of Makers::Maker, Makers.definitions.find(:author)
  end

end
