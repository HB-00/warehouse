module ApplicationHelper
  def active_tab(name)
    name == controller_name ? 'active' : ''
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

end
