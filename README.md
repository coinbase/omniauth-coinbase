# OmniAuth Coinbase

OmniAuth 2 strategy for [Coinbase](https://coinbase.com/)

For more details, read the [Coinbase API Reference](https://coinbase.com/docs/api/overview#oauth2)

# Installation

Add to your Gemfile:

```ruby
gem "omniauth-coinbase"
```

Then bundle install.

# Usage

Here's an example, adding the middleware to a Rails app in config/initializers/omniauth.rb:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :coinbase, ENV["COINBASE_KEY"], ENV["COINBASE_SECRET"]
end
```

You can now access the OmniAuth Coinbase OAuth2 URL: /auth/coinbase

# Configuration

You can configure permissions/scope, which you pass in to the `provider` method after your `COINBASE_KEY` and `COINBASE_SECRET`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :coinbase, ENV["COINBASE_KEY"], ENV["COINBASE_SECRET"], scope: 'user send addresses'
end
```

The format is a space separated list of strings from Coinbase's [list of OAuth Permissions](https://coinbase.com/docs/api/authentication#permissions). Remember that at minimum you MUST include either the 'all' or 'user' scopes.

NOTE: While developing your application, if you change the scope in the initializer you will need to restart your app server.
