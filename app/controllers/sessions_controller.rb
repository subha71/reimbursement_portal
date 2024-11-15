class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: "Logged in as #{user.name}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

end
