class Photo < ActiveRecord::Base
  validates :user_id, :url, presence: true

  belongs_to :user
  has_many :albums, through: :tags
end
