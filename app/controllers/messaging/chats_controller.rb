class Messaging::ChatsController < Messaging::MessagingController

  include Messaging::MessagesHelper

  before_action :set_chat, only: %i[ show send_message]

  def index
    @user = current_user
    @chats = @user.chats
    @friends = @user.friends
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
      format.js do
        render 'messaging/chats/show',
               locals: {
                 messages: @chat_messages,
                 chat: @chat,
                 chat_contact: @chat_contact,
                 messages_container_id: "chat-#{@chat.id}"
               }
      end
    end
  end

  # [POST] /messaging/chats/send_message/:id
  def send_message
    ActiveRecord::Base.transaction do
      @user = current_user
      @message = Message.new(content: params[:content], user: @user)
      @chat_message = ChatMessage.new(message: @message, chat: @chat)
      if @message.save && @chat_message.save
        ActionCable.server.broadcast "messaging/chat/#{@chat.id}",
                                     message: render_message(@chat_message),
                                     messages_container_id: "chat-#{@chat.id}"

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
end
