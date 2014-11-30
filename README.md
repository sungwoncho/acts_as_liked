# ActsAsLikeable [![Build Status](https://travis-ci.org/sungwoncho/acts_as_likeable.svg?branch=master)](https://travis-ci.org/sungwoncho/acts_as_likeable)

Add like feature to any Active Record models through polymorphic association. Designate any models to act as a `Liker` or `Likeable`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_likeable'
```

And then execute:

    $ bundle

Run generator:

    $ rails generate acts_as_likeable

And don't forget to migrate your database

    $ rake db:migrate

## Usage

### Likeable models

Add `acts_as_likeable` to any models, and its instances can be liked by other models.

```ruby
class Food < ActiveRecord::Base
  acts_as_likeable
end
```

### Liker models

Add `acts_as_liker` to any models, and it can like instances of other models.

```ruby
class Person < ActiveRecord::Base
  acts_as_liker
end
```

### API

Liker:

```ruby
# Creates a new like record for @user, and @post
@user.like(@post)

# Destroys the like record
@user.unlike(@post)

# Check if @user has liked @post
@user.liked?(@post) # Check if the user has liked the post
```

Likeable:

```ruby
# Count the number of likes of @post
@post.like_count

# Check if @post is liked by @user
@post.liked_by?(@user)
```

## Contributing

Issues and pull reqeusts are welcomed.