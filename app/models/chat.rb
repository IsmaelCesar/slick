class Chat < ApplicationRecord
  include CustomValidations
  belongs_to :user
  belongs_to :contact, class_name: 'User'

  validates :user, presence: true
  validates :contact, presence: true
  validates_with DifferenceChatValidator, on: :create

end
