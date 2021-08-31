class UserInvite < ApplicationRecord
  belongs_to :inviter
  belongs_to :invitee
end
