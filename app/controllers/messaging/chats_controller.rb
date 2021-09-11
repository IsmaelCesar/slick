class Messaging::ChatsController < Messaging::MessagingController

  before_action :set_chat, only: %i[ show send_message]

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
    @chat_contact = @chat.get_contact(current_user)
    @chat_messages = @chat.chat_messages.limit(20)
    respond_to do |format|
      format.js { render 'messaging/chats/show', locals: { messages: @chat_messages,
                                                           chat: @chat, 
                                                           chat_contact: @chat_contact} }
    end
  end

  # [POST] /messaging/chats/send_message/:id
  def send_message
    ActiveRecord::Base.transaction do
      @user = current_user
      @message = Message.new(content: params[:content], user: @user)
      @chat_message = ChatMessage.new(message: @message, chat: @chat)
      if @message.save && @chat_message.save
        #SendChatMessageJob.set(wait: 0.5.second).perform_later(@chat.id)
        ActionCable.server.broadcast "messaging/chat/#{@chat.id}",
                                      message: render_chat_message(@chat_message)
      end
    end
  end

  # [GET]  messaging/contacts/new_contact
  def new_contact
  end

  # [POST] messaging/contacts/create
  def create
  end
  
  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def render_chat_message(message)
    render(partial: 'messaging/messages/message',
           locals: { message: message },
           layout: false)
  end
end
