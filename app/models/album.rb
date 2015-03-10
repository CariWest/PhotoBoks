class Album < ActiveRecord::Base

  validates :title, :user_id, :tag_id, presence: true

  belongs_to :user
  belongs_to :tag
  has_many :photos, through: :tags
  has_many :authorized_users, through: :authorized_user

end
