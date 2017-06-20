class Authentications < Devise::OmniauthCallbacksController
  def steam
    @user = User.find_for_steam_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Steam") if is_navigational_format?
    else
      session["devise.steam_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
