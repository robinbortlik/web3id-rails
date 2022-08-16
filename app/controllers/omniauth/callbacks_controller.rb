class Omniauth::CallbacksController < Devise::OmniauthCallbacksController
	def web3id
		@account = Account.from_omniauth(request.env["omniauth.auth"])
		sign_in_and_redirect @account
	end
end
