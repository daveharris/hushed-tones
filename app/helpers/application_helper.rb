module ApplicationHelper
  def current_user
    session[:current_user]
  end

  def user_logged_in?
    current_user.present?
  end
end
