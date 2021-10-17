class Chat < ApplicationRecord
  include CustomValidations
  belongs_to :user
  belongs_to :contact, class_name: 'User'

  validates :user, presence: true
  validates :contact, presence: true
  validates_with DifferenceChatValidator, on: :create

  has_many :chat_messages, dependent: :destroy

  def get_contact(current_user)
    if current_user.id == user.id
      contact
    else
      user
    end
  end

end
