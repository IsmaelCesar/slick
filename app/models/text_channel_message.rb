class TextChannelMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :text_channel
  belongs_to :message
end
