class Friend < ApplicationRecord
  include CustomValidations
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  belongs_to :chat
  validates :chat, presence: true, on: %i[create update]
end
