class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_logged_in?

  def current_user
    session[:current_user]
  end

  def user_logged_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to(login_path) unless user_logged_in?
  end
end
