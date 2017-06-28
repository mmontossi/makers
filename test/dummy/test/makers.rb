Makers.define do

  trait :user do
    association :user, maker: :owner
  end

  maker :user, aliases: :owner do
    name 'name'
    username { name }
    sequence(:email) { |n| "mail#{n}@example.com" }
    sequence(:phone)
    posts

    maker :user_with_age do
      age 9
    end
    maker :user_with_posts do
      posts 2, strategy: :create
    end
  end

  maker :post, traits: :user

end
