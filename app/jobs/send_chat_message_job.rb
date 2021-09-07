class SendChatMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id)
    @chat = Chat.find(chat_id)
    @chat_message = @chat.chat_messages.last
    ActionCable.server.broadcast "messaging/chat/#{chat_id}", message: render_chat_message(@chat_message)
  end

  def render_chat_message(message)
    ApplicationController.renderer.render( partial: 'messaging/messages/message',
                                           locals: { message: message },
                                           layout: false)
  end

end
