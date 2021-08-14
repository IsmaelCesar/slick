class TextChannel < ApplicationRecord
  include MessageAttributes
  belongs_to :group
end
