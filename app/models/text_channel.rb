class TextChannel < ApplicationRecord
  belongs_to :group
  has_many :text_channel_messages, dependent: :destroy
end
