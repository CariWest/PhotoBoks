class Photo < ActiveRecord::Base
  validates :user_id, :url, presence: true

  belongs_to :user
  has_many :albums, through: :tags
  has_many :tags, through: :photo_tags
  has_many :photo_tags

  # GO READ ABOUT AR SCOPE
  scope :with_tag, -> (tag_name) {
    joins(:tags).where("tags.name" => tag_name)
  }
end
