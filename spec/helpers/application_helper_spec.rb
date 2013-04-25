require 'spec_helper'

describe ApplicationHelper do
  describe "#current_user" do
    it "should return the current user if logged in" do
      mock_user = mock(:user)
      helper.stub(:session) { {current_user: mock_user} }
      helper.current_user.should eq mock_user
    end

    it "should return the current user if logged in" do
      helper.current_user.should be_nil
    end
  end
end