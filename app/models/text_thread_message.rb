class TextThreadMessage < ApplicationRecord
  include MessageAttributes
  belongs_to :text_thread
  belongs_to :message
end
