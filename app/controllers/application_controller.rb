class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      return redirect_to login_path(redirect_url: request.fullpath)
    end
  end

  def authenticate_admin!
    return redirect_to root_path unless current_user&.admin?
  end
end
