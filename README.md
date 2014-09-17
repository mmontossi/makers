[![Gem Version](https://badge.fury.io/rb/fabricators.svg)](http://badge.fury.io/rb/fabricators) [![Code Climate](https://codeclimate.com/github/museways/fabricators/badges/gpa.svg)](https://codeclimate.com/github/museways/fabricators) [![Build Status](https://travis-ci.org/museways/fabricators.svg?branch=0.1.0)](https://travis-ci.org/museways/fabricators)

# Fabricators

Minimalistic factory inspired in factory_girl for rails.

## Install

Put this line in your Gemfile:
```ruby
gem 'fabricators', group: [:development, :test]
```

Then bundle:

    $ bundle

## Configuration

There is no need to configure anything, all this is done automatically for rspec and minitest:

* Loading the definitions.
* Replacing the fixtures generators.
* Including the methods inside your testing framework.
* Cleaning the database after each test.

## Usage

### Methods

There are three methods available:
```ruby
attributes_for
build
create
```

Is possible to override the defaults passing a hash:
```ruby
build :user, name: 'other'
create :category, title: 'other'
```

To create lists just pass the desired size as second parameter to build and create methods:
```ruby
build :user, 2, name: 'other'
create :category, 5, title: 'other'
```

### Fabricators

Define them in a ruby file inside test/fabricators or spec/fabricators folders:
```ruby
fabricator :user do
  name 'example'
end
```

### Inheritance

Can be declare nested or separated:
```ruby
fabricator :user do
  name 'example'
  fabricator :user_with_email do
    email 'example@mail.com'
  end
end
fabricator :user_with_age, parent: :user do
  age 9
end
```

### Sequences

Generates an unique sequence of numbers for the attribute of the fabricator:
```ruby
fabricator :user do
  sequence(:email) { |n| "example#{n}@mail.com" }
  sequence(:age)
end
```

### Associations

Associations are used by name:
```ruby
fabricator :user do
  posts
  comments 4 # You can customize the number of records
end
fabricator :post do
  user
end
fabricator :comment do
  user
end
```

### Aliases

The aliases are important when there is the need of context:
```ruby
fabricators :user, aliases: :author do
  comments
end
fabricators :post, aliases: :comment do
  title
  author
end
```

### Dependent attributes

If you need to use some logic that depends of another attribute you can use a block or sequence:
```ruby
fabricators :user do
  name 'example'
  email { "#{name}@mail.com" }
  sequence(:username) { |n| "#{name}-#{n}" }
end
```

### Callbacks

The available callbacks are before(:build), before(:create), after(:build) and after(:create):
```ruby
fabricator :user do
  after(:build) { |u| u.name = 'sample' }
end
```

You can declare global callbacks in your test or spec helper as well:
```ruby
Fabricators.configure do
  after(:create) do |object|
    log object.errors unless object.valid?
  end
end
```

## Credits

This gem is maintained and funded by [museways](http://museways.com).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
