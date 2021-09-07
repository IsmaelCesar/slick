class Messaging::ChatsController < Messaging::MessagingController
  def index
    @user = current_user
    @chats = @user.chats
    respond_to do |format|
      format.html
      format.js { render 'messaging/contacts/list_chats', locals: { chats: @chats } }
    end
  end

  # [GET]  messaging/contacts/new_contact
  def new_contact
  end

  # [POST] messaging/contacts/create
  def create
  end
  
end
