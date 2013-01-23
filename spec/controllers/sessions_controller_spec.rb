require 'spec_helper'

describe SessionsController do
  
  describe "POST create" do
    let(:attributes) { {'name' => 'Test', 'email' => 'test@example.com', 'password' => 'secret'} }
    let(:user) { User.create(attributes) }
    let(:user_session) { mock(:user_session, :save! => true, user: user) }

    it "should login with the authentication details provided" do
      UserSession.should_receive(:new).with(attributes) { user_session }
      post :create, user: attributes
    end

    it "should set the logged in user in the session" do
      UserSession.stub(:new) { user_session }
      post :create, user: attributes
      session[:current_user].should eq user
    end
  end
end