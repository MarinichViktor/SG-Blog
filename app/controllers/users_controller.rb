class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
       flash[:success] = "Please confirm your email address to continue"
      sign_in @user

    #  flash[:successful]=""
      redirect_to user_path(@user)
    else
      flash[:error]="Error"
      render :new
    end
  end
  def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
        Please sign in to continue."
        redirect_to root_path
      else
        flash[:error] = "Sorry. User does not exist"
        redirect_to root_path
      end
  end
  def show
    @user= User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:name,:email,:profile_img, :password, :password_confirmation)
  end
end
