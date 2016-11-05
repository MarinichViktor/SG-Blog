class CommentsController < ApplicationController
  before_action :authenticate

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:text,:user_id))
    @comment.user_id=current_user.id
    @comment.save
  respond_to  do |format|
    format.js
  end
  end

  def destroy
    @comment = Post.find(params[:post_id]).comments
    @comment.where(:id).destroy
  end

end
