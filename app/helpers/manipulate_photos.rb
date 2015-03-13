helpers do
  def get_photos_with_tag(tag_id)
    tag = Tag.find(tag_id)
    tag.photos
  end

  def get_sorted_photos(album_title)
    user = get_current_user
    if photos = user.photos.with_tag("sanfrancisco")
      photos.sort_by { |photo| photo.instagram_creation_time }
      return photos.reverse
    end
  end
end

