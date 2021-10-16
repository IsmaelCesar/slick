class ChatMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :message, dependent: :destroy
  belongs_to :chat, dependent: :destroy
end
