require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :profile_picture, :instagram_id, :access_token, presence: true
  validates :username, :instagram_id, :access_token, uniqueness: true

  has_many :albums
  has_many :photos
  has_many :friends, through: :friendships # not 100% sure about this one
  has_many :authorizations, through: :authorized_user # not 100% sure about this one

  # include BCrypt

  # def password
  #   @password ||= Password.new(password_hash) if password_hash
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end

  # def authenticate(password)
  #   self.password == password
  # end
end