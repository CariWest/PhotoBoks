class Tags < ActiveRecord::Base
  validates :tag, :album_id, :photo_id, presence: true

  belongs_to :album
  belongs_to :photo
end
