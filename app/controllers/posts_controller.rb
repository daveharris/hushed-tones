class PostsController < ApplicationController

  before_filter :find_post, only: [ :show, :edit, :update, :destroy ]

	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def edit
  end

  def create
    @post = Post.new(params[:post])
    @post.save!
    redirect_to posts_path
  end

  def update
    @post.update_attributes(params[:post])
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
