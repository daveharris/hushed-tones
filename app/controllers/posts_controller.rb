class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find params[:id]
	end

	def new
		@post = Post.new
	end

	def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.save
    redirect_to posts_path
  end

  def update
    @post = post.find(params[:id])
    @post.update_attributes(params[:post])
  end

  def destroy
    @post = post.find(params[:id])
    @post.destroy
  end
end
