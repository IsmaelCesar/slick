class TextThread < ApplicationRecord
  belongs_to :text_channel_message
  has_many :text_thread_message
end
