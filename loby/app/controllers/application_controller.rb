class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  protected

  def current_user
    @current_user ||= User.find_by(:id => session[:userid])
  end

  def signed_in?
    current_user
  rescue
    false
  end

  def verify_signed_in_user
    !!current_user
  end

  def sign_in(user)
    session[:userid] = user.id
    session[:credits] = 3
  end

  def sign_out
    reset_session
  end
end
