class Account < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:web3id]


  def self.from_omniauth(auth)
	  find_or_create_by(did: auth.uid) do |u|
      u.email = auth.info.email
      u.name = auth.info.name
    end
  end
end
