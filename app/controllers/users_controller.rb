class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user

    #  flash[:successful]=""
      redirect_to user_path(@user)
    else
      flash[:error]="Error"
      render :new
    end
  end

  def show
  end

  def user_params
    params.required(:user).permit(:name,:email,:profile_img, :password, :password_confirmation)
  end
end
