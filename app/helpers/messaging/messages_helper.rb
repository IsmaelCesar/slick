# Module dedicated to functionalities
# related to the messages being sent through the channels
module Messaging::MessagesHelper

  # Renders message to be sent through the chosen channel
  #
  # @param [Message::Any] message Model message or any of its children
  #
  # @return [html.erb] rendered message partial
  #
  def render_message(message)
    render(partial: 'messaging/messages/message',
           locals: { message: message },
           layout: false)
  end
end
