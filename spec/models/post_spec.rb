require 'spec_helper'

describe Post do
  let(:user) { User.create(name: 'Dave', email: 'dave@harris.org.nz') }
  let(:post) { Post.new(title: 'title', body: 'body', user: user) }

  describe "validations" do
    it "should be valid" do
      post.valid?.should be_true
    end

    [:title, :body, :user_id].each do |attribute|
      it "should validate the title exists" do
        post.send("#{attribute}=", "")
        post.valid?.should be_false
      end
    end
  end
end