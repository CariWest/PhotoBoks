helpers do

  def get_tag(tag_name)
    tag =Tag.where(name: tag_name).first
    if tag
      return tag
    else
      return Tag.create!(name: tag_name)
    end
  end

  def get_current_user(id)
    return User.find(id)
  end

  def add_photos_to_database_if_new_and_contain_tag(desired_tag)
    # album = Album.find(params[:id])
    # tag = album.tag.name
    user = User.find(session[:id])
    instagram_id = user.instagram_id

    response = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}")
    puts "httparty get request works"
    # response_data = JSON.parse(response.body)
    # photo_data = response_data["data"]

    photo_data = JSON.parse(response.body)["data"]

    photo_data.each do |individual_photo|
      next if photo_exists_in_db?(individual_photo["link"])

      all_tags = individual_photo["tags"]
      type = individual_photo["type"]
      if photo_is_image?(type) && photo_contains_tag?(desired_tag, all_tags)
        add_user_photo_to_db(user.id, individual_photo)
        photo = Photo.all.last
        add_all_tags_for_photo(photo.id, all_tags)
      end
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

  def find_or_create_tag(tag_name)
    return if Tag.find_by(name: tag_name)
    Tag.create!(name: tag_name)
  end

  def create_photo_tag_relationship(photo_id, tag_name)
    find_or_create_tag(tag_name)
    tag = Tag.all.last
    PhotoTag.create(tag_id: tag.id, photo_id: photo_id)
  end

  def add_all_tags_for_photo(photo_id, all_tags)
    return if all_tags.empty?
    all_tags.each { |tag_name| create_photo_tag_relationship(photo_id, tag_name) }
  end

  # MVP things to grab:
  # photo id, which is response_data["id"]
  # tags: response_data["tags"]
  # url: response_data["link"]
  # caption: response_data["caption"]["text"]
  # only images - type: response_data["type"] == "image"
  # Extra things to eventually grab:
  # likes
end
