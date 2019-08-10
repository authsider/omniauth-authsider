# Omniauth::Authsider

Welcome to the Authsider omniauth implementation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-authsider'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-authsider

## Usage

### Configuration

Since Authsider uses tenant based urls we need to use a setup proc. Put this somewhere at the top of your initializer.

```ruby
  SETUP_PROC = lambda do |env|
    req = Rack::Request.new(env)
    env['omniauth.strategy'].options[:client_options][:site] = ENV['AUTHSIDER_DOMAIN']
    env['omniauth.strategy'].options[:redirect_uri] = "YOURCALLBACKURL"
  end
```

#### Regular Omniauth
```ruby
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :authsider,
                    ENV['AUTHSIDER_ID'],
                    ENV['AUTHSIDER_SECRET'],
                    setup: SETUP_PROC
  end
```

#### Devise
```ruby
Devise.setup do |config|
  ...
  config.omniauth :authsider,
                    ENV['AUTHSIDER_ID'],
                    ENV['AUTHSIDER_SECRET'],
                    setup: SETUP_PROC
  ...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/authsider/omniauth-authsider.
