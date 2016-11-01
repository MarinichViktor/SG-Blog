class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :sign_in, :current_user, :user_signed_in?
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
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
    session.delete(:user_id)
    @current_user = nil
  end
end
