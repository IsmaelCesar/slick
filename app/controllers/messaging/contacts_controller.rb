class Messaging::ContactsController < ApplicationController

  def index
    @user = current_user
  end

end
