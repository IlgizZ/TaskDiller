class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create



  def create

    begin
      @user = User.from_omniauth request.env['omniauth.auth']
    rescue
      flash[:error] = "Can't authorize you..."
    else
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.nickname}!"
    end
    redirect_to root_path
  end
end
