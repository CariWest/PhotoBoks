class Album < ActiveRecord::Base
  validates :title, :user_id, :tag_id, presence: true
  # would love to also get the instagram photo id, but that's not working...

  belongs_to :user
  belongs_to :tag
  has_many :photos, through: :tag
  has_many :authorized_users, through: :authorized_user
end
