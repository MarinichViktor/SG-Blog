class SessionsController < ApplicationController
  def new
  end

  def create
    return false unless !user_signed_in?
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
