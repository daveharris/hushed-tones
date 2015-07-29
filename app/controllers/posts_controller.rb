class PostsController < ApplicationController

  before_filter :find_post, only: [ :show, :edit, :update, :destroy ]
  before_filter :authenticate_user!, except: [ :index, :show, :new ]

	def index
		@posts = Post.all
    @tags = Tag.joins(:posts).distinct
	end

	def show
	end

	def new
		@post = Post.new
	end

	def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: "#{@post.to_s} was successfully created."
    else
      render :new
    end
  end

  def update
    @post.user = current_user

    if @post.update(post_params)
      redirect_to @post, notice: "#{@post.to_s} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find_by!(slug: params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :title, :user, :picture, tag_ids: [], tags_attributes: [:id, :name, :_destroy])
  end
end
