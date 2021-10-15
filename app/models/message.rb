class Message < ApplicationRecord
  belongs_to :user
  belongs_to :answered_message, class_name: 'Message', foreign_key: 'answered_message_id'
end
