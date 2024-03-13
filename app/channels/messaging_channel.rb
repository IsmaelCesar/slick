# Channel dedicated to transmitting messages to resources
class MessagingChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # The resouce can be
    stream_from "messaging/#{params[:resource]}/#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
