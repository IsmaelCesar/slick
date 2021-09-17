class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /[a-zA-Z_]+[a-zA-Z0-1_]*@([a-zA-Z]+\.[a-zA-Z])+/i }, presence: true, uniqueness: true
  validates :password, presence: true

  def chats
    Chat.all.where("user_id= #{id}
                    OR contact_id=#{id}")
  end

  has_many :owned_groups, class_name: 'Group', foreign_key: 'user_adm_id'
  has_many :user_groups
  has_many :group_invites
  has_many :friends
  has_many :invites_sent, class_name: 'UserInvite', foreign_key: 'user_invite_id'
  has_many :invites_received, class_name: 'UserInvite', foreign_key: 'user_invitee_id'

  def all_user_groups
    # Returns all the groups the user participates or owns
    Group
      .left_joins(:user_groups, :user_adm)
      .where("groups.user_adm_id=#{id}
              OR user_groups.user_id=#{id}")
  end

end
