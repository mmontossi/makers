require 'test_helper'

class AliasesTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      generator :mobile, 0, aliases: :phone
      fabricator :user, aliases: [:owner, :author] do
        name 'name'
      end
    end
  end

  test "generator aliases" do
    assert_kind_of Fabricators::Generator, Fabricators.definitions.find(:mobile, :generator)
    assert_kind_of Fabricators::Generator, Fabricators.definitions.find(:phone, :generator)
  end

  test "fabricator aliases" do
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:user, :fabricator)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:owner, :fabricator)
    assert_kind_of Fabricators::Fabricator, Fabricators.definitions.find(:author, :fabricator)
  end

end
