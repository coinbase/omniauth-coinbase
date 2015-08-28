# OmniAuth Coinbase

OmniAuth 2 strategy for [Coinbase](https://www.coinbase.com/)

For more details, read the [Coinbase API Reference](https://developers.coinbase.com/api/v2)

# Release Notes

Note that version ~> 2.0 of this gem uses the new [Coinbase API v2](https://developers.coinbase.com/api/v2). Use this version if you are creating a new app. Do not upgrade existing apps to this version as the user ids in v2 of the API are not the same as those in v1. We will be adding v2 UUIDs to v1 responses to aid in migration efforts.

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
  provider :coinbase, ENV["COINBASE_CLIENT_ID"], ENV["COINBASE_CLIENT_SECRET"]
end
```

You can now access the OmniAuth Coinbase OAuth2 URL: /auth/coinbase

# Configuration

You can configure permissions/scope, which you pass in to the `provider` method after your `COINBASE_KEY` and `COINBASE_SECRET`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :coinbase, ENV["COINBASE_CLIENT_ID"], ENV["COINBASE_CLIENT_SECRET"], scope: 'wallet:user:read wallet:user:email wallet:accounts:read'
end
```

The format is a space separated list of strings from Coinbase's [list of OAuth Permissions](https://developers.coinbase.com/api/v2#scopes).

NOTE: While developing your application, if you change the scope in the initializer you will need to restart your app server.

# User info

The authenticated user's id and name are present in the omniauth auth object under auth.uid and auth.info.name.

The authenticated user's [raw information](https://developers.coinbase.com/api/v2#user-resource) is present under auth.extra.raw_info

```ruby
auth.uid # "7eee8527-3439-52d9-98d6-a04c0d0dc6ce"
auth.info.name # "Alex Ianus"
auth.extra.raw_info.email # "aianus@example.com", only present with wallet:user:email scope
auth.extra.raw_info.time_zone # "Pacific Time (US & Canada)", only present with wallet:user:show scope
```

# Sandbox support

Use omniauth-coinbase in development with our [developer sandbox](https://developers.coinbase.com/blog/2015/02/20/sandbox)

Note that you will need to create a separate sandbox OAuth application with its own client_id and secret.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :coinbase, ENV["COINBASE_CLIENT_ID"], ENV["COINBASE_CLIENT_SECRET"], scope: 'wallet:user:read', sandbox: true
end
```

```ruby
require 'coinbase/wallet'
client = Coinbase::Wallet::Client.new(api_key: <sandbox api key>, api_secret: <sandbox api secret>, api_url: "https://api.sandbox.coinbase.com")
```
