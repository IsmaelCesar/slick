class Messaging::ChatsController < Messaging::MessagingController
  def index
    @user = current_user
    @chats = @user.chats
    respond_to do |format|
      format.html
      format.js { render 'messaging/contacts/list_chats', locals: { chats: @chats } }
    end
  end

  # [GET] messaging/contacts/show/:id
  def show
    @chat = Chat.find(params[:id])
    @chat_contact = @chat.get_contact(current_user)
    @chat_messages = @chat.chat_messages.limit(20)
    respond_to do |format|
      format.js { render 'messaging/chats/show', locals: { messages: @chat_messages,
                                                           chat_contact: @chat_contact} }
    end
  end

  # [GET]  messaging/contacts/new_contact
  def new_contact
  end

  # [POST] messaging/contacts/create
  def create
  end
  
end
