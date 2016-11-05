class SessionsController < ApplicationController
# before_action :authenticate, only: [:destroy]

  def new
    if user_signed_in?
      redirect_to root_path
      flash[:danger]="You already loged in system."
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if( params[:session][:remember_me]=='1')
        remember_me(user)
      end
      sign_in user
      flash[:success]="You loged  in system."
      redirect_to user_path(user)
    else
      flash.now[:danger]="Invalid email/password"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
