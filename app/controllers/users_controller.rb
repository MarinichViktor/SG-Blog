class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
       flash[:success] = "Please confirm your email address to continue"

    #  flash[:successful]=""
      redirect_to user_path(@user)
    else
      flash[:error]="Error"
      render :new
    end
  end

  def search
   if @user = User.find_by(email: params[:email])
     @user.update_attribute(:reset_token, SecureRandom.urlsafe_base64.to_s)
     UserMailer.password_reset(@user).deliver
     @user.update_attribute(:reset_token, bcrypt_str(@user.reset_token))
     flash[:success]="Email with instructions to reset yours password was sended "
     redirect_to root_path
     #@user.update_attribute(:reset_token,bcrypt_str(@user.reset_token))

   else
     render 'email_find'
     flash[:error]="Error"
   end
  end
 def email_find

 end
 def edit
   @user = User.find(params[:id])
 end


 def update
   @user = User.find(params[:id])
   if  @user.update_attributes(user_params)
   redirect_to  user_path(@user)
   else
     flash[:danger]="Error "

    render "edit"
   end
 end
  def password_reset
    @user = User.find_by(email: params[:email])
    if BCrypt::Password.new(@user.reset_token).is_password?(params[:id])
      redirect_to edit_user_path(@user)
    else
      flash[:danger]="Error "
      redirect_to root_path
    end
  end

  def confirm_email
      user = User.find_by(confirm_token: params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome to the Sample App! Your email has been confirmed."


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
