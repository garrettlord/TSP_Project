module SessionsHelper
  def sign_in(user)
    session[:remember_token] = user.id
    self.current_user = user
  end

  def sign_out
    session[:remember_token] = nil
    current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end
end
