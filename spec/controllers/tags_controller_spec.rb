require 'spec_helper'

describe TagsController do
  
  describe "GET show" do
    let(:tag) { double(:tag).as_null_object }
    let(:posts) { [double(:post)] }

    it "should find the tag by name" do
      expect(Tag).to receive(:find_by).with(name: 'ruby') { tag }
      get :show, id: 'ruby'
      expect(assigns(:tag)).to eq tag
    end

    it "should assign the Posts with the tag as @posts" do
      allow(Tag).to receive(:find_by) { double(:tag, posts: posts) }
      get :show, id: 'ruby'
      expect(assigns(:posts)).to eq posts
    end

    context "tag not found" do
      before do
        allow(Tag).to receive(:find_by) { nil }
      end

      it "should show the 404 page" do
        expect { get :show, id: 'ruby' }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end