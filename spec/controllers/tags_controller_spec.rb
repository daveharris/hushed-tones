require 'spec_helper'

describe TagsController do
  
  describe "GET show" do
    let(:tag) { double(:tag).as_null_object }
    let(:posts) { [double(:post)] }

    it "should find the tag by name" do
      Tag.should_receive(:find_by).with(name: 'ruby') { tag }
      get :show, id: 'ruby'
      assigns(:tag).should eq tag
    end

    it "should assign the Posts with the tag as @posts" do
      Tag.stub(:find_by) { double(:tag, posts: posts) }
      get :show, id: 'ruby'
      assigns(:posts).should eq posts
    end

    context "tag not found" do
      before do
        Tag.stub(:find_by) { nil }
      end

      it "should show the 404 page" do
        get :show, id: 'ruby'
        response.should redirect_to '/404'
      end
    end
  end
end