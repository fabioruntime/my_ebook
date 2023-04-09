module LoginHelpers
  def login(user)
    user = User.where(email: user.email).first if user.is_a?(Symbol)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id]) if !request.session.blank? && request.session.has_key?(:user_id)
  end
end
