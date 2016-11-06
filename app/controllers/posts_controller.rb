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
    if @post.save
      flash[:success] = "You have added new post."
      redirect_to  post_path(@post)
    else
     flash[:danger] = "There was an error during adding new post."
     render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
     @post = Post.find(params[:id])
     @user = @post.user
  end

  def update
    @post = Post.find(params[:id])
    if  @post.update(post_params)
      flash[:success]= "Post was successfully updated."
      redirect_to  post_path(@post)
    else
      flash.now[:danger]="There was an error."
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success]= "Post was successfully deleted."
    redirect_to root_path
  end

  private

  def post_params
    params.required(:post).permit(:body,:title,:user_id,:image,:remove_image)
  end
end
