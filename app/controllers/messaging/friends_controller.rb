class Messaging::FriendsController < Messaging::MessagingController
  before_action :set_current_user

  def index
    @friends = @current_user.friends
    respond_to do |format|
      format.js { render 'messaging/friends/index', locals: { friends: @friends } }
    end
  end

  # [DELETE] friends/destroy/:id'
  def destroy
    @friend = Friend.find(params[:id])
    @friend_relation = Friend.find_by(user: @friend.friend)
    @chat = @friend.chat
    ActiveRecord::Base.transaction do
      if @friend.destroy && @friend_relation.destroy && @chat.destroy
        redirect_to messaging_chats_index_path
      else
        respond_to do |format|
          format.js { render js: "alertify.error('#{@friend.errors.full_messages}')"}
        end
      end
    end
  end

  private 

  def set_current_user
    @current_user = current_user
  end

end
