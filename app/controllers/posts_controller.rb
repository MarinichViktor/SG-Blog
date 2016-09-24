class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  def show
     @post = Post.find(params[:id])
   rescue ActiveRecord::RecordNotFound
   redirect_to "/"
   return
  end
end
