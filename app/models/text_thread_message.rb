class TextThreadMessage < ApplicationRecord
  belongs_to :text_thread
  belongs_to :message
end
