module ApplicationHelper

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        sign_in(user)
      end
    end
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def is_a_current_user?(user)
    user == current_user
  end

  def authenticate
    unless user_signed_in?
      redirect_to new_session_path
      flash[:danger]="You need to login."
    end
  end

  def sign_out
    return false unless user_signed_in?
    current_user.update_attribute(:remember_digest,nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
    current_user = nil
  end

  def remember_me(user)
    remember_token = User.secure_random_str
    user.update_attribute(:remember_digest, User.bcrypt_str(remember_token))
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end
end
