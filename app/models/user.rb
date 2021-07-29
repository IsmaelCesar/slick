class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, format: /[a-zA-Z_]+[a-zA-Z0-1_]*@([a-zA-Z]+\.[a-zA-Z])+/i, presence: true, uniqueness: true
    validates :password, presence: true

    has_many :contacts

end
