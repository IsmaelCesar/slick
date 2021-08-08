class UserInvite < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: 'user_inviter_id'
  belongs_to :invitee, class_name: 'User', foreign_key: 'user_invitee_id'

  before_create do
    is_accepted = true
  end

end
