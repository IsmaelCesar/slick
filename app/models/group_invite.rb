class GroupInvite < ApplicationRecord
  #this is an alteration 
  include CustomValidations
  belongs_to :user
  belongs_to :group

  validates :user, presence: true
  validates :group, presence: true
  validates_with UserInviteeDifferentFromOwner, on: :create
end
