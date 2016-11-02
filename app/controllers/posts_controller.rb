class PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  def index
    @posts = Post.all
  end


    def new
    @post= current_user.posts.new
    end

  def create
    @post = current_user.posts.new(post_params)
   if  @post.save
   redirect_to  post_path(@post)
   else
    render "new"
   end
  #   render :show
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
    if  @post.update(post_params)
    redirect_to  post_path(@post)
    else
     render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end


private

def post_params
  params.required(:post).permit(:body,:title,:image,:remove_image)
end

end
