class ChatMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :message
  belongs_to :chat
end
