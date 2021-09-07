class UserInvite < ApplicationRecord
  include CustomValidations
  belongs_to :inviter, class_name: 'User', foreign_key: 'user_invite_id'
  belongs_to :invitee, class_name: 'User', foreign_key: 'user_invitee_id'
  validates :inviter, presence: true, on: %i[crate update]
  validates :invitee, presence: true, on: %i[create update]
  validates_with DifferenceInviteValidator, on: %i[create update]
end
