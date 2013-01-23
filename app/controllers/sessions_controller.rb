class SessionsController < ApplicationController

  before_filter :new_user
  
  def new
  end

  def create
    params.symbolize_keys
    puts "==== params[:user]: #{params[:user]}"
    @session = UserSession.new(params[:user])
    @session.save!
    session[:current_user] = @session.user
    flash[:notice] = "Welcome back #{@session.user.name}, you are now logged in!"
    redirect_to root_path

    rescue LetMeIn::Error
      flash.now[:error] = "Wrong email address or password"
      render action: :new
  end

  private
    def new_user
      @user = User.new(params[:user])
    end
end
