require 'spec_helper'

describe SessionsController do
  
  describe "POST create" do
    let(:attributes) { {'name' => 'Test', 'email' => 'test@example.com', 'password' => 'secret'} }
    let(:user) { User.create(attributes) }
    let(:user_session) { mock(:user_session, :save! => true, user: user) }

    before(:each) do
      UserSession.stub(:new) { user_session }
    end

    it "should login with the authentication details provided" do
      UserSession.should_receive(:new).with(attributes) { user_session }
      post :create, user: attributes
    end

    it "should set the logged in user in the session" do
      post :create, user: attributes
      session[:current_user].should eq user
    end

    it "should redirect to the homepage" do
      post :create, user: attributes
      request.should redirect_to root_path
    end

    it "should display an error message if incorrect credentials" do
      user_session.stub(:save!).and_raise(LetMeIn::Error)
      post :create, user: attributes
      flash.now[:error].should be_present
      request.should render_template('sessions/new')
    end

    it "should render the new template if incorrect credentials" do
      user_session.stub(:save!).and_raise(LetMeIn::Error)
      post :create, user: attributes
      request.should render_template('sessions/new')
    end
  end

  describe "GET destroy" do
    before(:each) do
      session[:current_user] = mock(:user_session)
    end

    it "should delete the user session" do
      get :destroy
      session[:current_user].should be_nil
    end

    it "should redirect to the homepage" do
      get :destroy
      flash.now[:notice].should be_present
      request.should redirect_to root_path
    end

    it "should display a message" do
      get :destroy
      flash.now[:notice].should be_present
    end
  end
end