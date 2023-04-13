class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to(login_path)
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = "You must have an administrator profile to access."
      redirect_to(login_path)
    end
  end

  def require_owner_user
    user = User.find(params[:id])
    if current_user != user && !current_user.admin?
      redirect_to(user, alert: "You can only edit or delete your own account")
    end
  end
end
