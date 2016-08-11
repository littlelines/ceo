CEO
---

> Your app's chief executive.

[![Dependency Status](http://img.shields.io/gemnasium/littlelines/ceo.svg)](https://gemnasium.com/littlelines/ceo)
[![Gem Version](http://img.shields.io/gem/v/ceo.svg)](https://rubygems.org/gems/ceo)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://littlelines.mit-license.org)
[![Build Status](https://travis-ci.org/littlelines/ceo.svg?branch=master)](https://travis-ci.org/littlelines/ceo)
[![Code Climate](https://codeclimate.com/github/littlelines/ceo/badges/gpa.svg)](https://codeclimate.com/github/littlelines/ceo)
[![Inline docs](http://inch-ci.org/github/littlelines/ceo.svg?branch=master)](http://inch-ci.org/github/littlelines/ceo)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ceo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ceo

## Usage

For basic CRUD that just works:

    $ bundle exec rails generate admin apples

This will create:
  + *app/controllers/admin/apples_controller.rb*
  + *app/views/admin/apples/_form.html.erb*

And route: `admin_for :apples`

Creating all apple resource routes namespaced under admin.

### Authentication

Every generated controller will call `#authenticate_admin!` before every action.
This does nothing if `#authenticate_admin!` is not defined in your application.
You must write your own `#authenticate_admin!` method in your `ApplicationController`.

### Getting started

Start up your server and visit [http://localhost:3000/admin/apples](). Customize
the apples form in *app/views/admin/apples/_form.html.erb*, where:

    <%= # "f" is exposed as a form object %>

[SimpleForm](https://github.com/plataformatec/simple_form) can be used here to
maintain style consistency with the rest of the provided admin panel.

Once this form is fleshed out, you will be able to create, read, update, and
destroy apples at will.

### Customization

To customize what attributes appear at */admin/apples* and/or
*/admin/apples/:id*, you can pass a hash using the keys `:only` (show
__*only*__ these attributes), `:except` (show everything __*except*__ these
attributes), and/or `:query` (show attributes of associated objects).

#### Example

`apple_instance` responds to `name` and `product_id` where `Apple`
`has_many :seeds` and `Seed` responds to count.

*app/controllers/admin/apples_controller.rb*

```ruby
module Admin
  class ApplesController < CEOController
    # Only shows ID, Name, and Seed Count in admin#index table.
    def index
      super(
        only: [:id, :name],
        query: ['seeds.count']
      )
    end

    def show
      super(
        # Displays all of apple's attributes as well as its seeds.count in
        # admin#show.
        query: ['seeds.count']
      )
    end
  end
end
```

### Further Customization

Need something more customizable/complex than basic CRUD functionality? Instead
of working around a black box, simply inherit from `AdminController` instead of
`CEOController` for a clean slate:

```ruby
module Admin
  class ApplesController < AdminController
    # Plain old Rails controller
  end
end
```

### _Even Further_ Customization

If none of these options is right for you, you can override or add to
`AdminController` by simply creating a `AdminMiddleware` module in
your Rails application path (we suggest services or initializers, but
it's up to you).

### Styling

For consistency in styling, you can find the CEO styleguide at
[http://localhost:3000/admin/styleguide]() after installing CEO in your
application.

You can also override some defaults for the whole admin panel by setting up `AdminMiddleware`.

```
module AdminMiddleware
  extend ActiveSupport::Concern

  included do
    layout 'my_admin'
    before_action :my_method
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install
dependencies. Then, run `rake test` to run the tests. You can also run
`bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake
install`.

## TODO
* [ ] Allow option to generate views in HAML
* [ ] Make adding content/customizing dashboard easier

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/littlelines/ceo.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

