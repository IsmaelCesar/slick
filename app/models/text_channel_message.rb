class TextChannelMessage < ApplicationRecord
  belongs_to :text_channel
  belongs_to :message
end
