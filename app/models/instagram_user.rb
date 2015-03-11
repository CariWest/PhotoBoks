class InstagramUser < ActiveRecord::Base
  validates :username, :profile_picture, :instagram_id, presence: true
end
