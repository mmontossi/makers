[![Gem Version](https://badge.fury.io/rb/makers.svg)](http://badge.fury.io/rb/makers)
[![Code Climate](https://codeclimate.com/github/museways/makers/badges/gpa.svg)](https://codeclimate.com/github/museways/makers)
[![Build Status](https://travis-ci.org/museways/makers.svg)](https://travis-ci.org/museways/makers)
[![Dependency Status](https://gemnasium.com/museways/makers.svg)](https://gemnasium.com/museways/makers)

# Makers

Minimalistic factories to replace fixtures in rails.

## Why

I did this gem to:

- Enforce better practices removing unnecessary options.
- Avoid the need to use another method to build/create lists.
- Quicker syntax to handle associations.

## Install

Put this line in your Gemfile:
```ruby
gem 'makers', group: [:development, :test]
```

Then bundle:
```
$ bundle
```

## Configuration

Generate de definitions file:
```
$ bundle exec rails g makers:install
```

The file will be put in test/makers.rb or spec/makers.rb depending on your test framework:
```ruby
Makers.define do
end
```

## Usage

### Inheritance

Just concatenate makers:
```ruby
Makers.define do

  maker :user do
    name 'example'

    maker :user_with_email do
      email 'example@mail.com'
    end
  end

end
```

### Sequences

Generates an unique sequence of numbers for an attribute:
```ruby
Makers.define do

  maker :user do
    sequence(:email) { |n| "example#{n}@mail.com" }
    sequence(:phone)
  end

end
```

### Associations

Associations are defined by name or by the association method:
```ruby
Makers.define do

  maker :user do
    posts
    comments 4, strategy: :create
  end

  maker :comment do
    association :user
  end

  maker :post do
    user
  end

end
```

### Aliases

Aliases can be assigned in the initialization:
```ruby
Makers.define do

  maker :user, aliases: :author do
    comments
  end

  maker :post, aliases: %i(comment article) do
    title
    author
  end

end
```

### Dependent attributes

If you need to use some logic that depends of another attribute you can use a block:
```ruby
Makers.define do

  maker :user do
    name 'example'
    email { "#{name}@mail.com" }
    sequence(:username) { |n| "#{name}-#{n}" }
  end

end
```

### Methods

There are two new methods available in tests:
```ruby
build
create
```

Is possible to override the defaults passing a hash:
```ruby
build :user, name: 'other'
create :category, title: 'other'
```

To create lists just pass the desired size as second parameter:
```ruby
build :user, 2, name: 'other'
create :category, 5, title: 'other'
```

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

I will mainly ensure compatibility to Rails, AWS, PostgreSQL, Redis, Elasticsearch and FreeBSD. 

## Credits

This gem is maintained and funded by [museways](https://github.com/museways).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
