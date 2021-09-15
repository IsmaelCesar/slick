class Messaging::FriendsController < Messaging::MessagingController
  before_action :set_current_user

  def index
    @friends = @current_user.friends
    respond_to do |format|
      format.js { render 'messaging/friends/index', locals: { friends: @friends } }
    end
  end

  private 

  def set_current_user
    @current_user = current_user
  end

end
