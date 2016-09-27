class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
     @post = Post.find(params[:id])
   rescue ActiveRecord::RecordNotFound
   redirect_to root_path
   return
  end

  def new
  @post= Post.new

end

def create
  @post = Post.new(article_params)
 if  @post.save
 render  :show
 else
  render "new"
 end
#   render :show
end

private
def article_params
  params.required(:post).permit(:body,:title)
end

end
