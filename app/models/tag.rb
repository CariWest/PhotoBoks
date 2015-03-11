class Tag < ActiveRecord::Base
  validates :name, presence: true
  # validation doesn't work? Debug later.
  # validates :name, format: { with: /#{1}\w+[^\s]/ }

  has_many :photos, through: :photo_tags
  has_many :photo_tags
  has_many :albums
end
