require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :password_hash, :email, presence: true
  validates :username, :email, uniqueness: true

  has_many :albums
  has_many :photos
  has_many :friends, through: :friendships # not 100% sure about this one
  has_many :authorizations, through: :authorized_user # not 100% sure about this one

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password_attempt)
    self.password_hash == password_attempt
  end
end
