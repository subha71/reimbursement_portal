class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  
  def create
    begin
      auth = request.env['omniauth.auth']
      raise "OmniAuth data missing" if auth.blank?

      provider = auth['provider']
      uid = auth['uid']
      name = auth.dig('info', 'name')
      email = auth.dig('info', 'email')

      raise "Authentication data incomplete: provider, uid, name, or email missing" if provider.blank? || uid.blank? || name.blank? || email.blank?
      user = User.find_or_create_by(provider: provider, uid: uid) do |u|
        u.name = name
        u.email = email
      end

      if user.persisted?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in as #{user.name}"
      else
        redirect_to root_path, alert: "There was an issue creating your account. Please try again."
      end
    rescue => e
      redirect_to root_path, alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

end
