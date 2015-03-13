helpers do
  def get_photos_with_tag(tag_id)
    tag = Tag.find(tag_id)
    tag.photos
  end

  # def get_photos_which_belong_to_user_and_album(user, album)
  #   albums.user.photos
  # end

  def get_sorted_photos(album_title)
    user = get_current_user(session[:id])
    if photos = user.albums.find_by(title: album_title).photos
      photos.sort_by { |photo| photo.instagram_creation_time }
      return photos.reverse
    end
  end
end

