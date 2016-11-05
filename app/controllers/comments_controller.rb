class CommentsController < ApplicationController
  before_action :authenticate

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: params[:comment][:text])
    current_user.comments << @comment
    @comment.save
  #redirect_to post_path(@post)
  respond_to  do |format|
    format.js
  end
  end

  def destroy
    @comment = Post.find(params[:post_id]).comments
    @comment.where(:id).destroy
  end

end
