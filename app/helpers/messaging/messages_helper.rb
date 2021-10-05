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

  #
  # Renders the actions exclusive to message sender such as edit and
  # delete, if the current user is acctualy the sender of the message.
  #
  # @param [Message] message the message model
  #
  # @return [Nil] nil
  #
  def render_user_exclusive_actions(message)
    if current_user.id == message.user.id
      render(partial: 'messaging/messages/message_sender_exclusive_actions',
             message: message,
             layout: false)
    end
  end

end
