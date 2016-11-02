class SessionsController < ApplicationController
  def new
    if user_signed_in?
      redirect_to root_path
      flash[:error]="You already loged"
    end
  end

  def create
    user = User.find_by(:email => params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if( params[:session][:remember_me]=='1')
        remember_me(user)
      end
      sign_in user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
