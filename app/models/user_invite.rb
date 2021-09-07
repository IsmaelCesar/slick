class DifferenceValidator < ActiveModel::Validator
  def validate(record)
    if record.invitee.id == record.inviter.id
      record.errors.add :inviter, 'Cannot be same as invitee'
    end
  end
end

class UserInvite < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: 'user_invite_id'
  belongs_to :invitee, class_name: 'User', foreign_key: 'user_invitee_id'
  validates :inviter, presence: true, on: %i[crate update]
  validates :invitee, presence: true, on: %i[create update]
  validates_with DifferenceValidator, on: %i[create update]
end
