class TextChannelMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :message
  belongs_to :text_channel
end
