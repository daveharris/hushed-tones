class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(name: params[:id])
    if @tag
      @posts = @tag.posts
    else
      redirect_to '/404'
    end
  end
end
