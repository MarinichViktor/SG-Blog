class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if ( cookies.signed[:user_id])
       user = User.find_by(id: cookies.signed[:user_id])
      if  user && user.authenticated?(cookies[:remember_token])
        sign_in(user)
      end
    end
      @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate
    redirect_to new_session_path unless user_signed_in?
    flash[:errors]="You need to login"
  end

  def sign_out
    return false unless user_signed_in?
    @current_user.update_attribute(:remember_digest,nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember_me(user)
    remember_token = secure_random_str
    user.update_attribute(:remember_digest, bcrypt_str(remember_token))
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end
end
