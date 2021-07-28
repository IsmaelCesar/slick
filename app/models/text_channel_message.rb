class TextChannelMessage < ApplicationRecord
  belongs_to :message
  belongs_to :text_channel
end
