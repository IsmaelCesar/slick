class TextChannelMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :text_channel
  belongs_to :message
  has_one :text_thread
end
