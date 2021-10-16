class Message < ApplicationRecord
  belongs_to :user
  belongs_to :answered_message, class_name: 'Message', foreign_key: 'answered_message_id', optional: true

  has_one :chat_messages, dependent: :destroy
  has_one :text_channel_message, dependent: :destroy
  has_one :text_thread_message, dependent: :destroy

end
