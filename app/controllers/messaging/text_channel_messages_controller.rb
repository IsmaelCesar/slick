class Messaging::TextChannelMessagesController < Messaging::MessagingController
  include Messaging::MessagesHelper

  # [POST]  /messaging/text_channel/:id/send_text_channel_message
  def send_text_channel_message
    @text_channel = TextChannel.find(params[:id])

    ActiveRecord::Base.transaction do
      @message = Message.new(message_params)
      @text_channel_message = TextChannelMessage.new(message: @message,
                                                     text_channel: @text_channel)
      if @message.save! && @text_channel_message.save!
        ActionCable.server.broadcast "messaging/text_channel/#{@text_channel.id}",
                                     message: render_message(@text_channel_message),
                                     messages_container_id: "text-channel-#{@text_channel.id}"
      end
    end
  end

  private

  def message_params
    params.permit(:user_id, :content)
  end

end
