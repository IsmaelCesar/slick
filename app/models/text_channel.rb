class TextChannel < ApplicationRecord
  belongs_to :group
  has_many :text_channel_messages, dependent: :delete_all
  has_many :text_threads, dependent: :destroy
end
