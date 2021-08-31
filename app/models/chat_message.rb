class ChatMessage < ApplicationRecord
  belongs_to :message
  belongs_to :chat
end
