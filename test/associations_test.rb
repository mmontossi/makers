require 'test_helper'

class AssociationsTest < ActiveSupport::TestCase

  setup do
    Fabricators.define do
      fabricator :user do
        fabricator :user_with_built_posts do
          posts
        end
        fabricator :user_with_created_posts do
          posts 2, strategy: :create
        end
      end
      fabricator :post do
        fabricator :post_with_built_user do
          user
        end
        fabricator :post_with_created_user do
          user strategy: :create
        end
      end
    end
  end

  test 'belongs to association' do
    user = build(:post_with_built_user).user
    assert_kind_of User, user
    assert user.new_record?

    user = build(:post_with_created_user).user
    assert_kind_of User, user
    assert user.persisted?
  end

  test 'has many association' do
    posts = build(:user_with_built_posts).posts
    assert_equal 1, posts.size
    post = posts.first
    assert_kind_of Post, post
    assert post.new_record?

    posts = build(:user_with_created_posts).posts
    assert_equal 2, posts.size
    post = posts.first
    assert_kind_of Post, post
    assert post.persisted?
  end

end
