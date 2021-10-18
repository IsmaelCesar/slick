class Friend < ApplicationRecord
  include CustomValidations
  include UserAttributes
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  belongs_to :chat
  validates :chat, presence: true, on: %i[create update]
end
