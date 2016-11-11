Makers.define do

  maker :user, aliases: %i(owner) do
    name 'name'
    sequence(:username) { name }
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

  maker :post

end
