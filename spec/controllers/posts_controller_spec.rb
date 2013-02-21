require 'spec_helper'

describe PostsController do
  let(:mock_post) { mock(:post).as_null_object }

  describe "GET index" do
    it "should assign @posts as all the posts" do
      Post.stub(:all) { mock_post }
      get :index
      assigns(:posts).should eq mock_post
    end  
  end

  describe "GET show" do
    it "should assign @post" do
      Post.stub(:find).with('1') { mock_post }
      get :show, id: '1'
      assigns(:post).should eq mock_post
    end
  end

  describe "GET new" do
    it "should assign @post as new Post" do
      Post.stub(:new) { mock_post }
      get :new
      assigns(:post).should eq mock_post
    end
  end

  describe "GET edit" do
    it "should assign @post as new Post" do
      Post.stub(:find) { mock_post }
      get :edit, id: '1'
      assigns(:post).should eq mock_post
    end
  end

  describe "POST create" do
    {id: '1', body: 'body', title: 'title'}.each do |attribute, value|
      it "should set the #{attribute}" do
        post :create, post: {id: '1', body: 'body', title: 'title'}
        assigns(:post).send(attribute).to_s.should eq value
      end
    end

    it "should should save the post" do
      Post.stub(:new) { mock_post }
      mock_post.should_receive(:save!)
      post :create, post: {id: '1', body: 'body', title: 'title'}
    end

    it "should redirect to /posts after saving" do
      post :create, post: {id: '1', body: 'body', title: 'title'}
      response.should redirect_to(posts_path)
    end
  end

  describe "POST update" do
    it "should find the Post" do
      Post.should_receive(:find).with('1') { mock_post }
      post :update, id: '1'
    end

    it "should update the Post" do
      Post.stub(:find).with('1') { mock_post }
      mock_post.should_receive(:update_attributes).with('title' => 'title')
      post :update, { id: '1', post: {title: 'title'} }
    end

    it "should assign the updated Post to @post" do
      Post.stub(:find) { mock_post }
      mock_post.stub(:update_attributes) { mock_post }
      post :update, id: '1'
      assigns(:post).should eq mock_post
    end

    it "should redirect to /posts" do
      Post.stub(:find) { mock_post }
      post :update, id: '1'
      response.should redirect_to posts_path
    end
  end

  describe "DELETE destroy" do
    it "should find the Post" do
      Post.should_receive(:find).with('1') { mock_post }
      delete :destroy, id: '1'
    end

    it "should destroy the Post" do
      Post.stub(:find) { mock_post }
      mock_post.should_receive(:destroy)
      delete :destroy, id: '1'
    end

    it "should assign @post as deleted Post" do
      Post.stub(:find) { mock_post }
      get :edit, id: '1'
      assigns(:post).should eq mock_post
    end

    it "should redirect to /posts" do
      Post.stub(:find) { mock_post }
      post :update, id: '1'
      response.should redirect_to posts_path
    end
  end
end