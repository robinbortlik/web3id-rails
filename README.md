# WEB3ID Rails example

This repo contains example rails application which integrates devise with web3id authenitication strategy.

### What is web3id?

- please refer to [official website](https://www.dock.io/web3id)

## Example app setup

- clone repo `git clone git@github.com:robinbortlik/web3id-rails.git`
- generate your web3id `key/secret` as per instructions in [official documentation](https://github.com/docknetwork/auth-server/blob/master/docs/oauth2_setup.md)
- update `.env` file
- `bundle install`
- `bundle exec rake db:setup`
- start server `bundle exec rails s`
- open `http://localhost:3000` in your browser

## How to configure your devise with web3id ?

- add `omniauth-web3id` gem to your Gemfile
- configure `web3id` strategy in devise config

```ruby
  config.omniauth(:web3id,
    ENV.fetch("WEB3ID_CLIENT_ID"),
    ENV.fetch("WEB3ID_CLIENT_SECRET_KEY"),
    callback_path: '/oauth/callback'
  )
```

- define omniauth callbacks controller

```ruby
class Omniauth::CallbacksController < Devise::OmniauthCallbacksController
  def web3id
    @account = Account.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @account
  end
end
```

- register new controller in routes.rb

```ruby
devise_for :accounts, :controllers => { :omniauth_callbacks => "omniauth/callbacks" }
devise_scope :account do
  get "/oauth/callback" => "omniauth/callbacks#web3id"
end
```

- register omniauth provider in your devise model

```ruby
class Account < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:web3id]
end
```

- add login button to your html template

```ruby
<%= form_tag account_web3id_omniauth_authorize_path, data: { turbo: false } do %>
  <button>Login</button>
<% end %>
```
