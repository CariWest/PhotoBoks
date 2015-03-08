class User < ActiveRecord::Base
  validates :username, :password_hash, :email, presence: true
  validates :username, :email, uniqueness: true

  has_many :albums
  has_many :photos
  has_many :friends, through: :friendships # not 100% sure about this one
  has_many :authorizations, through: :authorized_user # not 100% sure about this one
end
