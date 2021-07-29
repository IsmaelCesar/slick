class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authorized?
    redirect_to presentation_user_login_path unless logged_in?
  end

end
