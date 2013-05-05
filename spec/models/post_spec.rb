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

  describe "#body_html" do
    before(:each) do
      post.body = 'h1. Title'
    end

    it "should use RedCloth to convert plain text to html" do
      RedCloth.should_receive(:new).with("h1. Title") {mock(:redclock, to_html: '')}
      post.body_html
    end

    it "should convert the body attribute to html" do
      post.body_html.should eq "<h1>Title</h1>"
    end
  end

  describe "#display_date" do
    it "should return the date in human readable form" do
      # Not using Timecop so I don't have to save record
      post.stub(:created_at) { Time.parse("2013-04-19 15:49:20 +1200") }
      post.display_date.should eq "Fri Apr 19 03:49PM"
    end
  end
end