class AuthorizedUser < ActiveRecord::Base
  validates :user_id, :album_id, presence: true

  belongs_to :album
  belongs_to :user
end
