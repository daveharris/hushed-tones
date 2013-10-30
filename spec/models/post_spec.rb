require 'spec_helper'

describe Post do
  let(:user) { User.create(name: 'Dave', email: 'dave@harris.org.nz') }
  let(:post) { Post.new(title: 'title', body: 'body', user: user) }

  describe "validations" do
    it "should be valid" do
      post.valid?.should be_true
    end

    [:title, :body, :user_id].each do |attribute|
      it "should validate that the #{attribute} exists" do
        post.public_send("#{attribute}=", "")
        post.valid?.should be_false
      end
    end

    it "should validate the slug generates a non-empty string" do
      post.title = '&'
      post.valid?.should be_false
    end
  end

  describe "#tags" do
    it "should not create a tag if it's empty" do
      post.tags_attributes = {"0"=>{"name"=>""}}
      post.save!
      post.tags.size.should eq 0
    end
  end

  describe "#body_html" do
    before(:each) do
      post.body = 'h1. Title'
    end

    it "should use RedCloth to convert plain text to html" do
      RedCloth.should_receive(:new).with("h1. Title") { double(:redclock, to_html: '') }
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

  describe "#to_param" do
    it "should return a parameterized title" do
      post.title = 'The Title & Description'
      post.save!
      post.to_param.should eq 'the-title-description'
    end
  end

  describe "#slugify" do
    it "should set the slug when saving" do
      post.title = 'post title'
      post.save
      post.slug.should eq 'post-title'
    end
  end

  describe "#lookup_existing_tags" do
    let(:tag) { Tag.create(name: "ruby") }

    before do
      post.tags = [tag]
    end

    it "should call lookup_existing_tags before_save" do
      post.should_receive(:lookup_existing_tags)
      post.save
    end

    it "should add existing tag if exists in database" do
      new_tag = Tag.new(name: "rails")
      post.tags = [Tag.new(name: "ruby"), new_tag]
      post.save

      post.reload.tags.first.should eq tag
      post.tags.last.should eq new_tag
    end

    it "should return true to trigger later callbacks" do
      post.send(:lookup_existing_tags).should eq true
    end

    it "should not add duplicate tags" do
      post.tags = [Tag.new(name: "ruby")]
      post.save

      post.reload.tags.size.should eq 1
      post.tags.first.should eq tag
    end
  end
end