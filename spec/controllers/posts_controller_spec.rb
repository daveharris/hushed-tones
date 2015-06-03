require 'spec_helper'

describe PostsController do
  let(:user) { double(:user) }
  let(:mock_post) { double(:post).as_null_object }

  describe "GET index" do
    it "should assign @posts as all the posts" do
      allow(Post).to receive(:all) { mock_post }
      get :index
      expect(assigns(:posts)).to eq mock_post
    end  
  end

  describe "GET show" do
    it "should assign @post" do
      allow(Post).to receive(:find_by).with(slug: '1') { mock_post }
      get :show, id: '1'
      expect(assigns(:post)).to eq mock_post
    end
  end

  describe "GET new" do
    it "should assign @post as new Post" do
      allow(Post).to receive(:new) { mock_post }
      get :new
      expect(assigns(:post)).to eq mock_post
    end
  end

  describe "GET edit" do
    it "should assign @post as new Post" do
      allow(Post).to receive(:find_by).with(slug: '1') { mock_post }
      get :edit, id: '1'
      expect(assigns(:post)).to eq mock_post
    end
  end

  describe "POST create" do
    before(:each) do
      allow(controller).to receive(:session) { {current_user: user} }
      allow(Post).to receive(:new) { mock_post }
      allow(mock_post).to receive(:save!)
      allow(mock_post).to receive(:user=)
    end

    it "should set the attributes on the Post" do
      expect(Post).to receive(:new).with({'body' => 'body', 'title' => 'title'})
      post :create, post: {body: 'body', title: 'title'}
    end

    it "should set the user on the post" do
      expect(mock_post).to receive(:user=).with(user)
      post :create, post: {body: 'body', title: 'title'}
    end

    it "should should save the post" do
      expect(mock_post).to receive(:save!)
      post :create, post: {body: 'body', title: 'title'}
    end

    it "should redirect to /posts after saving" do
      post :create, post: {body: 'body', title: 'title'}
      expect(response).to redirect_to post_path(mock_post)
    end
  end

  describe "POST update" do
    before do
      allow(controller).to receive(:session) { {current_user: user} }
      allow(Post).to receive(:find_by).with(slug: '1') { mock_post }

      allow(mock_post).to receive(:update_attributes)
      allow(mock_post).to receive(:user=).with(user)
    end

    it "should find the Post" do
      expect(Post).to receive(:find_by).with(slug: '1') { mock_post }
      post :update, id: '1', post: {title: 'Title'}
    end

    it "should set the user on the post" do
      expect(mock_post).to receive(:user=).with(user)
      post :update, id: '1', post: {title: 'Title'}
    end

    it "should update the Post" do
      expect(mock_post).to receive(:update_attributes).with('title' => 'title')
      post :update, { id: '1', post: {title: 'title'} }
    end

    it "should update the tags of the post" do
      expect(mock_post).to receive(:update_attributes).with('tag_ids' => ['1', '2'])
      post :update, { id: '1', post: {tag_ids: [1,2]} }
    end

    it "should assign the updated Post to @post" do
      post :update, id: '1', post: {title: 'Title'}
      expect(assigns(:post)).to eq mock_post
    end

    it "should redirect to /posts" do
      post :update, id: '1', post: {title: 'Title'}
      expect(response).to redirect_to post_path(mock_post)
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      allow(controller).to receive(:session) { {current_user: user} }
      allow(Post).to receive(:find_by).with(slug: '1') { mock_post }
    end

    it "should find the Post" do
      expect(Post).to receive(:find_by).with(slug: '1') { mock_post }
      delete :destroy, id: '1'
    end

    it "should destroy the Post" do
      expect(mock_post).to receive(:destroy)
      delete :destroy, id: '1'
    end

    it "should assign @post as deleted Post" do
      delete :destroy, id: '1'
      expect(assigns(:post)).to eq mock_post
    end

    it "should redirect to /posts" do
      delete :destroy, id: '1'
      expect(response).to redirect_to posts_path
    end
  end
end