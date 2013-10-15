require 'spec_helper'

describe PostsController do
  let(:user) { mock_model(User) }
  let(:mock_post) { mock_model(Post) }

  describe "GET index" do
    it "should assign @posts as all the posts" do
      Post.stub(:all) { mock_post }
      get :index
      assigns(:posts).should eq mock_post
    end  
  end

  describe "GET show" do
    it "should assign @post" do
      Post.stub(:find_by).with(slug: '1') { mock_post }
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
      Post.stub(:find_by).with(slug: '1') { mock_post }
      get :edit, id: '1'
      assigns(:post).should eq mock_post
    end
  end

  describe "POST create" do
    before(:each) do
      controller.stub(:session) { {current_user: user} }
      Post.stub(:new) { mock_post }
      mock_post.stub(:save!)
      mock_post.stub(:user=)
    end

    it "should set the attributes on the Post" do
      Post.should_receive(:new).with({'id' => '1', 'body' => 'body', 'title' => 'title'})
      post :create, post: {id: '1', body: 'body', title: 'title'}
    end

    it "should set the user on the post" do
      mock_post.should_receive(:user=).with(user)
      post :create, post: {id: '1', body: 'body', title: 'title'}
    end

    it "should should save the post" do
      mock_post.should_receive(:save!)
      post :create, post: {id: '1', body: 'body', title: 'title'}
    end

    it "should redirect to /posts after saving" do
      post :create, post: {id: '1', body: 'body', title: 'title'}
      response.should redirect_to post_path(mock_post)
    end
  end

  describe "POST update" do
    before do
      controller.stub(:session) { {current_user: user} }
      Post.stub(:find_by).with(slug: '1') { mock_post }

      mock_post.stub(:update_attributes)
      mock_post.stub(:user=).with(user)
    end

    it "should find the Post" do
      Post.should_receive(:find_by).with(slug: '1') { mock_post }
      post :update, id: '1', post: {title: 'Title'}
    end

    it "should set the user on the post" do
      mock_post.should_receive(:user=).with(user)
      post :update, id: '1', post: {title: 'Title'}
    end

    it "should update the Post" do
      mock_post.should_receive(:update_attributes).with('title' => 'title')
      post :update, { id: '1', post: {title: 'title'} }
    end

    it "should assign the updated Post to @post" do
      post :update, id: '1', post: {title: 'Title'}
      assigns(:post).should eq mock_post
    end

    it "should redirect to /posts" do
      post :update, id: '1', post: {title: 'Title'}
      response.should redirect_to post_path(mock_post)
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      controller.stub(:session) { {current_user: user} }
      Post.stub(:find_by).with(slug: '1') { mock_post }
    end

    it "should find the Post" do
      Post.should_receive(:find_by).with(slug: '1') { mock_post }
      delete :destroy, id: '1'
    end

    it "should destroy the Post" do
      mock_post.should_receive(:destroy)
      delete :destroy, id: '1'
    end

    it "should assign @post as deleted Post" do
      delete :destroy, id: '1'
      assigns(:post).should eq mock_post
    end

    it "should redirect to /posts" do
      delete :destroy, id: '1'
      response.should redirect_to posts_path
    end
  end
end