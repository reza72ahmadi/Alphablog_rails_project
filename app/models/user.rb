class User < ApplicationRecord
    before_save {self.email = email.downcase}
    has_many :articles
    validates :username, presence: true,
                length: {minimum: 3 , maximum:15},
                uniqueness: true
    VALI_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :email, presence: true,
                length:{minimum: 5, maximum:100},
                uniqueness: true,
                format: { with: VALI_EMAIL_REGEX }
                
     has_secure_password        
end
