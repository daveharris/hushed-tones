require 'spec_helper'

describe Post do
  let(:user) { User.create(name: 'Dave', email: 'dave@harris.org.nz') }
  let(:post) { Post.new(title: 'title', body: 'body', user: user) }

  describe "validations" do
    it "should be valid" do
      expect(post.valid?).to be_truthy
    end

    [:title, :body, :user_id].each do |attribute|
      it "should validate that the #{attribute} exists" do
        post.public_send("#{attribute}=", "")
        expect(post.valid?).to be_falsey
      end
    end

    it "should validate the slug generates a non-empty string" do
      post.title = '&'
      expect(post.valid?).to be_falsey
    end
  end

  describe "#tags" do
    it "should not create a tag if it's empty" do
      post.tags_attributes = {"0"=>{"name"=>""}}
      post.save!
      expect(post.tags.size).to eq 0
    end
  end

  describe "#body_html" do
    before(:each) do
      post.body = 'h1. Title'
    end

    it "should use RedCloth to convert plain text to html" do
      expect(RedCloth).to receive(:new).with("h1. Title") { double(:redclock, to_html: '') }
      post.body_html
    end

    it "should convert the body attribute to html" do
      expect(post.body_html).to eq "<h1>Title</h1>"
    end
  end

  describe "#to_param" do
    it "should return a parameterized title" do
      post.title = 'The Title & Description'
      post.save!
      expect(post.to_param).to eq 'the-title-description'
    end
  end

  describe "#slugify" do
    it "should set the slug when saving" do
      post.title = 'post title'
      post.save
      expect(post.slug).to eq 'post-title'
    end
  end
end