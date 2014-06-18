require 'test_helper'

class AliasesTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      attribute(:mobile, aliases: :phone)
      fabricator :user, aliases: [:owner, :author] do
        name 'name'
        phone
      end
    end
  end

  test "generator aliases" do
    assert_kind_of Fabricators::Attribute, Fabricators.definitions.find(:mobile, :attribute)
    assert_kind_of Fabricators::Attribute, Fabricators.definitions.find(:phone, :attribute)
  end

  test "fabricator aliases" do
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:user, :fabricator)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:owner, :fabricator)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:author, :fabricator)
  end

end
