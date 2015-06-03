require 'spec_helper'

describe SessionsController do
  
  describe "POST create" do
    let(:attributes) { {'name' => 'Test', 'email' => 'test@example.com', 'password' => 'secret'} }
    let(:user) { User.create(attributes) }
    let(:user_session) { double(:user_session, :save! => true, user: user) }

    before(:each) do
      allow(UserSession).to receive(:new) { user_session }
    end

    it "should login with the authentication details provided" do
      expect(UserSession).to receive(:new).with(attributes) { user_session }
      post :create, user: attributes
    end

    it "should set the logged in user in the session" do
      post :create, user: attributes
      expect(session[:current_user]).to eq user
    end

    it "should redirect to the homepage" do
      post :create, user: attributes
      expect(request).to redirect_to root_path
    end

    it "should display an error message if incorrect credentials" do
      allow(user_session).to receive(:save!).and_raise(LetMeIn::Error)
      post :create, user: attributes
      expect(flash.now[:error]).to be_present
      expect(request).to render_template('sessions/new')
    end

    it "should render the new template if incorrect credentials" do
      allow(user_session).to receive(:save!).and_raise(LetMeIn::Error)
      post :create, user: attributes
      expect(request).to render_template('sessions/new')
    end
  end

  describe "GET destroy" do
    before(:each) do
      session[:current_user] = double(:user_session)
    end

    it "should delete the user session" do
      get :destroy
      expect(session[:current_user]).to be_nil
    end

    it "should redirect to the homepage" do
      get :destroy
      expect(flash.now[:notice]).to be_present
      expect(request).to redirect_to root_path
    end

    it "should display a message" do
      get :destroy
      expect(flash.now[:notice]).to be_present
    end
  end
end