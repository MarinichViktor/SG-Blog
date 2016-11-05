class UsersController < ApplicationController
before_action :find_id, only: [:show,:edit,:update]
before_action :authenticate, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "<b>#{user.name}</b>"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:success] = "Hi #{@user.name}!. Welcome to SG Blog .Please confirm your email address to continue."
      sign_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def search
    if @user = User.find_by(email: params[:email])
      @user.generate_reset_token
      UserMailer.password_reset(@user).deliver_now
      @user.update_attribute(:reset_token, User.bcrypt_str(@user.reset_token,1))
      flash[:success]="Email with instructions to reset yours password was sended."
      redirect_to root_path
    else
      flash.now[:danger]="Invalid email."
      render 'email_find'
    end
  end

  def email_find
  end

  def edit
  end

  def update
    prev = Rails.application.routes.recognize_path(request.referrer)
    if prev[:action]== 'password_reset'
      if  @user.update_attributes(user_params)
        sign_in @user
        redirect_to  user_path(@user)
      else
        flash.now[:danger]="Password doesn match with confirmation."
        render "password_reset"
      end
    else
      if BCrypt::Password.new(@user.password_digest).is_password?(params[:password])
        if @user.update_attributes(user_params)
          redirect_to  user_path(@user)
        else
          flash.now[:danger]="Invalid password "
          render "edit"
        end
      else
       flash.now[:danger]="Invalid password "
       render 'edit'
     end
    end
  end

  def show
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sg Blog! Your email has been confirmed."
      redirect_to root_path
    else
      flash[:danger] = "There was an error during email activation."
      redirect_to root_path
    end
  end

  def password_reset
    @user = User.find_by(email: params[:email])
    if !@user.is_reset_token?
      flash[:danger]="Reset token is not available anymore."
      redirect_to root_path
    else
      if BCrypt::Password.new(@user.reset_token).is_password?(params[:id])
        flash.now[:success]="Enter new password."
        render 'password_reset'
      else
        flash[:danger]="Invalid token for this email."
        redirect_to root_path
      end
    end
  end

  private

  def find_id
    @user= User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:name,:email,:profile_img,:city, :password, :password_confirmation, :remove_profile_img)
  end

end
