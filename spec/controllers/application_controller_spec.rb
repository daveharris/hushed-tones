require "spec_helper"

describe ApplicationController do
  controller do
    before_filter :authenticate_user!
    def index
      render nothing: true
    end
  end

  describe "#authenticate_user!" do
    it "should force the user to login if not logged in" do
      controller.stub(:user_logged_in?) { false }
      get :index
      response.should redirect_to login_path
    end

    it "should no nothing if the user is already logged in" do
      controller.stub(:user_logged_in?) { true }
      get :index
      response.should_not redirect_to login_path
    end
  end

  describe "#current_user" do
    it "should return the current user if logged in" do
      @mock_user = double(:user)
      controller.stub(:session) { {current_user: @mock_user} }

      controller.current_user.should eq @mock_user
    end

    it "should return nil if not logged in" do
      controller.current_user.should be_nil
    end
  end
end