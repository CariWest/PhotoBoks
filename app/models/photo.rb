class Photo < ActiveRecord::Base
  validates :user_id, :url, presence: true

  belongs_to :user
  has_many :albums, through: :tags
  has_many :tags, through: :photo_tags
  has_many :photo_tags


end
