class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :user_signed_in?
  before_action :authenticate_user!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to root_path, alert: 'You need to log in first' unless user_signed_in?
  end

  private 

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "You need to sign in to access this page."
      redirect_to root_path
    end
  end
  
end
