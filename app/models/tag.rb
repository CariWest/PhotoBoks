class Tag < ActiveRecord::Base
  validates :tag, :album_id, :photo_id, presence: true

  has_many :photos, through: :photo_tags
  has_many :photo_tags
  has_many :albums
end
