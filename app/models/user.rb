class User < ActiveRecord::Base
    # authentication method via bcrypt
    has_secure_password
    validates_presence_of :email
    validates_uniqueness_of :email
end
