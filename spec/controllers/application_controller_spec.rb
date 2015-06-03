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
      allow(controller).to receive(:user_logged_in?) { false }
      get :index
      expect(response).to redirect_to login_path
    end

    it "should no nothing if the user is already logged in" do
      allow(controller).to receive(:user_logged_in?) { true }
      get :index
      expect(response).not_to redirect_to login_path
    end
  end

  describe "#current_user" do
    it "should return the current user if logged in" do
      @mock_user = double(:user)
      allow(controller).to receive(:session) { {current_user: @mock_user} }

      expect(controller.current_user).to eq @mock_user
    end

    it "should return nil if not logged in" do
      expect(controller.current_user).to be_nil
    end
  end
end