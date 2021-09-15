class Group < ApplicationRecord

  belongs_to :user_adm, class_name: 'User', foreign_key: 'user_adm_id'
  has_many :user_groups
  has_many :text_channels

  validates :user_adm, presence: true
  validates :name, presence: true

end
