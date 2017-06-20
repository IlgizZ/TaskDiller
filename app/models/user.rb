class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:steam]

  def self.find_for_steam_oauth(auth, signed_in_resource=nil)
   user = User.where(provider: auth.provider, uid: auth.uid).first

   unless user
     user = User.create(name: auth.info.nickname,
                        provider: auth.provider,
                        uid: auth.uid,
                        email: "no-email@steam.provider",
                        password: Devise.friendly_token[0,20])
   end

   user
  end
end
