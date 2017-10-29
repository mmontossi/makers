require 'test_helper'

class MakerTest < ActiveSupport::TestCase

  test 'methods' do
    assert_equal 'other', build(:user, name: 'other').name
    list = build(:user, 3, name: 'other')
    3.times do |index|
      assert_equal 'other', list[index].name
    end

    assert_equal 'other', create(:user, name: 'other').name
    list = create(:user, 3, name: 'other')
    3.times do |index|
      assert_equal 'other', list[index].name
    end
  end

  test 'blocks' do
    assert_equal 'name', build(:user).username
    assert_equal 'name', create(:user).username
  end

  test 'inheritance' do
    user = build(:user_with_age)
    assert_equal 'name', user.name
    assert_equal 9, user.age

    user = create(:user_with_age)
    assert_equal 'name', user.name
    assert_equal 9, user.age
  end

  test 'sequences' do
    assert_operator build(:user).email, :<, create(:user).email
    assert_operator build(:user).phone, :<, create(:user).phone
  end

  test 'aliases' do
    user = Makers.definitions.get(:user)
    assert_kind_of Makers::Maker, user
    assert_equal user, Makers.definitions.get(:owner)
  end

  test 'associations' do
    posts = build(:user).posts
    assert_equal 1, posts.size
    post = posts.first
    assert post.new_record?

    posts = build(:user_with_posts).posts
    assert_equal 2, posts.size
    posts.each do |post|
      assert post.persisted?
    end
  end

  test 'traits' do
    post = build(:post, :with_user)
    assert_kind_of User, post.user
  end

  test 'registry' do
    assert_raises do
      Makers.get :wrong
    end
    assert_raises do
      Makers.add :user
    end
  end

end
