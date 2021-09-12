class Group < ApplicationRecord

  belongs_to :user_adm, class_name: 'User', foreign_key: 'user_adm_id'
  has_many :user_groups

  validates :user_adm, presence: true
  validates :name, presence: true

end
