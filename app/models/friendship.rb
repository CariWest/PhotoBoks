class Friendship < ActiveRecord::Base
  validates :user_id, :friend_id, presence: true
  # validation to only allow for unique friendships?
  # or change this to followerships?

  belongs_to :user
  belongs_to :friend, class_name: Friend
  # not 100% sure about these associations...
end
