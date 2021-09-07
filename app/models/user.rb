class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /[a-zA-Z_]+[a-zA-Z0-1_]*@([a-zA-Z]+\.[a-zA-Z])+/i }, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :chats
  has_many :user_groups
  has_many :invites_sent, class_name: 'UserInvite', foreign_key: 'user_inviter_id'
  has_many :invites_received, class_name: 'UserInvite', foreign_key: 'user_invitee_id'

end
