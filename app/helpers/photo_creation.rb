helpers do
  def add_photos_to_database_if_new_and_contain_tag(desired_tag)
    # album = Album.find(params[:id])
    # tag = album.tag.name
    user = get_current_user(session[:id])
    instagram_id = user.instagram_id

    response = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}")
    puts "httparty get request works"
    # response_data = JSON.parse(response.body)
    # photo_data = response_data["data"]

    photo_data = JSON.parse(response.body)["data"]

    count = 0
    photo_data.each do |individual_photo|
      next if photo_exists_in_db?(individual_photo["link"])

      all_tags = individual_photo["tags"]
      type = individual_photo["type"]
      if photo_is_image?(type) && photo_contains_tag?(desired_tag, all_tags)
        add_user_photo_to_db(user.id, individual_photo)
        photo = Photo.all.last
        all_tags = get_all_tags(all_tags)
        set_tag_relationships_for_photo(photo, all_tags)
      end
      count += 1
    end
  end

  def photo_contains_tag?(desired_tag, all_tags)
    all_tags.each do |tag|
      return true if tag == desired_tag
    end
    false
  end

  def photo_is_image?(type)
    type == "image"
  end

  def add_user_photo_to_db(user_id, individual_photo)
    Photo.create!(
      url:                "#{individual_photo['link']}",
      # instagram_photo_id: "#{individual_photo['id']}",
      # caption:            "#{individual_photo['caption']}",
      user_id:            user_id
    )
    puts "photo creates successfully"
  end

  def photo_exists_in_db?(photo_url)
    Photo.find_by(url: photo_url)
  end

  def create_photo_tag_relationship(photo_id, tag_id)
    PhotoTag.create(tag_id: tag_id, photo_id: photo_id)
  end

  def get_all_tags(all_tags)
    return if all_tags.empty?
    tags = all_tags.map do |tag_name|
      find_or_create_tag(tag_name)
    end
    return tags
  end

  def set_tag_relationships_for_photo(photo, all_tags)
    all_tags.each do |tag|
      create_photo_tag_relationship(photo.id, tag.id)
    end
  end

end

# PHOTO TAGS ARE ONLY BEING CREATED ONCE
