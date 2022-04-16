class User < ActiveRecord::Base
    # authentication method via bcrypt
    has_secure_password
end
