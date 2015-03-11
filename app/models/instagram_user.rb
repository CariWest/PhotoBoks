class InstagramUser < ActiveRecord::Base
  validates :username, :profile_picture, :instagram_id, presence: true

  has_many :albums
  has_many :photos
  has_many :friends, through: :friendships
  has_many :authorizations, through: :authorized_user
end
