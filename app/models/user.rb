class User < ActiveRecord::Base
    # authentication method via bcrypt
    has_secure_password
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :email
    validates_uniqueness_of :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
