helpers do
  # need to utilize the API call to specify max_id
  def hit_api_to_get_photos
    @user = get_current_user(session[:id])
    response = get_media_from_IG(@user.instagram_id)
    get_IG_data(response)
  end

  # to get older photos, use the API call to specify max_id and move back through the IG feed
  def populate_album_for_first_time(tag)
    tag = find_or_create_tag(tag)
    hit_api_to_get_photos
    add_all_photos_from_one_page(tag.name)
  end

  def add_all_photos_from_one_page(tag)
    @photo_data.each do |individual_photo|
      photo = get_photo_if_it_exists(individual_photo)
      next if photo
      add_photo_to_database(individual_photo)
    end
  end

  def check_for_new_photos(tag)
    hit_api_to_get_photos
    @photo_data.each do |individual_photo|
      photo = get_photo_if_it_exists(individual_photo)
      return if photo
      add_photo_to_database(individual_photo)
    end
  end

  def add_photo_to_database(individual_photo)
    if photo_is_image?(individual_photo)
      photo = create_photo(individual_photo)
      create_tags(photo)
      set_tag_relationships_for_photo(photo)
    end
  end

  def get_IG_data(response)
    json_object = JSON.parse(response.body)
    @next_max_id = json_object["pagination"]["next_max_id"]
    @photo_data = json_object["data"]
  end

  def get_photo_if_it_exists(individual_photo)
    photo_url = get_URL(individual_photo)
    Photo.find_by(url: photo_url)
  end

  def photo_is_image?(individual_photo)
    individual_photo["type"] == "image"
  end

  def create_photo(individual_photo)
    photo = Photo.create!(
      user_id:                  @user.id,
      url:                      get_URL(individual_photo),
      instagram_url:            individual_photo['link'],
      instagram_creation_time:  individual_photo['created_time']
    )
    return photo
  end

  def get_URL(individual_photo)
    individual_photo["images"]["standard_resolution"]["url"]
  end

  # need to add ability to specify what the max ID is in this method
  def get_media_from_IG(instagram_id)
    p "INSTAGRAM ID: #{instagram_id}"
    return HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}")
  end

  def set_tag_relationships_for_photo(photo)
    all_tags = photo.tags
    all_tags.each do |tag|
      create_photo_tag_relationship(photo.id, tag.id)
    end
  end
end