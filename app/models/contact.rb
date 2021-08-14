class Contact < ApplicationRecord
  include UserContactAttributes
  belongs_to :user
  belongs_to :user_contact, class_name: 'User'

  validates :user_contact, presence: true
end
