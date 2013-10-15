class SessionsController < ApplicationController

  before_filter :new_user, only: [:new, :create]
  
  def new
  end

  def create
    @session = UserSession.new(user_params)
    @session.save!
    session[:current_user] = @session.user
    flash[:notice] = "Welcome back #{@session.user.name}, you are now logged in!"
    redirect_to root_path

    rescue LetMeIn::Error
      flash.now[:error] = "Wrong email address or password"
      render action: :new
  end

  def destroy
    session[:current_user] = nil
    flash[:notice] = "You are now logged out!"
    redirect_to root_path
  end

  private
    def new_user
      @user = User.new(user_params)
    end

    def user_params
      params.fetch(:user, {}).permit(:email, :name, :password)
    end
end
