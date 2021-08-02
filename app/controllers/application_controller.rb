class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authorized?
    redirect_to messaging_contacts_index_path if logged_in?
  end

  def not_authorized?
    redirect_to presentation_user_login_path unless logged_in?
  end

end
