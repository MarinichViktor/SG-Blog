class CommentsController < ApplicationController
  def method_name
    @post = Post.find(params)
    @comment = @post.comments.create(params.require(:comments).permit(:text))
    redirect_to post_path(@post)
  end
end
