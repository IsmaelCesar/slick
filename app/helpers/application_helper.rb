module ApplicationHelper

  def user_login(user)
    session[:user_id] = user.id
  end

  def user_logout
    session[:user_id] = nil
  end

  def current_user
    if session[:user_id].present? && !session[:user_id].nil?
      User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

end
