require 'test_helper'

class FabricatorsTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        name 'name'
      end
    end
  end

  test 'return attributes' do
    hash = attributes_for(:user)
    assert_kind_of Hash, hash
    assert_equal 'name', hash[:name]
  end

  test 'build instance' do
    record = build(:user)
    assert_kind_of User, record
    assert record.new_record?
    assert_equal 'name', record.name
  end

  test 'create instance' do
    record = create(:user)
    assert_kind_of User, record
    assert record.persisted?
    assert_equal 'name', record.name
  end

end
