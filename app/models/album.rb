class Album < ActiveRecord::Base

  validates :title, presence: true

  belongs_to :user
  has_many :photos, through: :tags
  has_many :authorized_users, through: :authorized_user

end
