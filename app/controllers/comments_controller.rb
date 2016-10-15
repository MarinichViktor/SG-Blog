class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params.require(:comment).permit(:text))
    respond_to do |format|
      format.html {redirect_to post_path(@post)}
      format.js
    end
  end
end
