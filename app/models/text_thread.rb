class TextThread < ApplicationRecord
  belongs_to :text_channel_message
  belongs_to :text_channel
  has_many :text_thread_messages
end
