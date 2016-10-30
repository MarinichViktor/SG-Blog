class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params.require(:comment).permit(:text))
  respond_to  do |format|
    format.js
  end
  end

  def destroy
    @comment = Post.find(params[:post_id]).comments
    @comment.where(:id).destroy
  end
end
