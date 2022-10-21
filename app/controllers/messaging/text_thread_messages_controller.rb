class Messaging::TextThreadMessagesController < Messaging::MessagingController
  include Messaging::MessagesHelper

  def send_message
    @user = current_user
    @text_thread = TextThread.find(params[:text_thread_id])
    @message = Message.new(content: params[:content],
                           answered_message_id: params[:answered_message_id],
                           user: @user)
    @text_thread_message = TextThreadMessage.new(message: @message, text_thread: @text_thread)
    ActiveRecord::Base.transaction do
      if @message.save && @text_thread_message.save
        ActionCable.server.broadcast "messaging/text_thread/#{@text_thread.id}",{
                                        message: render_message(@text_thread_message),
                                        user_id: @user.id,
                                        messages_container_id: "text-thread-#{@text_thread.id}"
                                     }
      end
    end
  end
end
