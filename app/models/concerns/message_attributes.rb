# Module to give access to the messages' attributes
module MessageAttributes
  extend ActiveSupport::Concern

  def content
    message&.content
  end

  def user
    message&.user
  end

  #
  # Returns the answer of the current message
  #
  def answer
    message_class = self.class
    message_class.joins(:message)
                 .where(message: {
                   message: message.message
                 })
                 .first
  end

end