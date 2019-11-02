class User < ActiveRecord::Base
    has_secure_password #user needs a password to be saved
    validates :email, :presence => true #user objects cannot be saved without an email
    has_many :books
end 