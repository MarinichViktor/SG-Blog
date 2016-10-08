class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
     @post = Post.find(params[:id])
   rescue ActiveRecord::RecordNotFound
   redirect_to root_path
   return
  end

  def update
    @post = Post.find(params[:id])
    @post.update(article_params)
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
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
  params.required(:post).permit(:body,:title,:image)
end

end
