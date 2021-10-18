class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authorized?
    redirect_to messaging_chats_index_path if logged_in?
  end

  def not_authorized?
    if !logged_in?
      redirect_to presentation_user_login_path
    else
      @user = current_user
    end
  end

end
