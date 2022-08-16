Rails.application.routes.draw do
  devise_for :accounts, :controllers => { :omniauth_callbacks => "omniauth/callbacks" }
  devise_scope :account do
    get "/oauth/callback" => "omniauth/callbacks#web3id"
  end

  get "/logout", to: "home#logout"
  root "home#index"
end
