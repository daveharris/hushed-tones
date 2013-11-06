class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_logged_in?

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def current_user
    session[:current_user]
  end

  def user_logged_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to(login_path) unless user_logged_in?
  end

  private
  
  def render_404
    render 'public/404.html', status: 404
  end
end
