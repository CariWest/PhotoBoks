helpers do
  def get_photos_with_tag(tag_id)
    tag = Tag.find(tag_id)
    tag.photos
  end
end