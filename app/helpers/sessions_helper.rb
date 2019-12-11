module SessionsHelper
  def logged_in?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def log_in user
    session[:user_id] = user.id
    cookies.signed_or_encrypted[:user_id] = user.id
  end
end
