class Message < ApplicationRecord
  # this is another alteration
  belongs_to :user
  belongs_to :answered_message, class_name: 'Message', foreign_key: 'answered_message_id', optional: true

  has_one :chat_message, dependent: :destroy
  has_one :text_channel_message, dependent: :destroy
  has_one :text_thread_message, dependent: :destroy

  before_destroy :remove_dependents

  def remove_dependents
    puts "Remove depentends"
    chat_message&.destroy
    text_channel_message&.destroy
    text_thread_message&.destroy
  end

end
