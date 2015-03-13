helpers do
  # need to utilize the API call to specify max_id
  def hit_api_to_get_photos
    @user = get_current_user
    response = get_user_media_from_IG(@user.instagram_id)
    extract_IG_data(response)
  end

  # to get older photos, use the API call to specify max_id and move back through the IG feed
  def populate_album_for_first_time(tag)
    @next_max_id = nil
    tag = find_or_create_tag(tag)

    7.times do
      hit_api_to_get_photos
      photo_data = @photo_data # stubbed; will refactor this away later
      add_all_photos_from_one_page(tag.name, photo_data)
    end
  end

  # def populate_album_for_first_time(tag)
  #   tag = find_or_create_tag(tag)
  #   hit_api_to_get_photos
  #   photo_data = @photo_data # stubbed; will refactor this away later
  #   add_all_photos_from_one_page(tag.name, photo_data)
  # end

  def add_all_photos_from_one_page(tag, photo_data)
    photo_data.each do |individual_photo_IG_data|
      photo = get_photo_if_it_exists(individual_photo_IG_data)
      next if photo
      add_photo_to_db_if_tag_matches(tag, individual_photo_IG_data)
    end
  end

  def check_for_new_photos(tag)
    hit_api_to_get_photos
    @photo_data.each do |individual_photo_IG_data|
      photo = get_photo_if_it_exists(individual_photo_IG_data)
      return if photo
      add_photo_to_db_if_tag_matches(tag, individual_photo_IG_data)
    end
  end

  def add_photo_to_db_if_tag_matches(tag, individual_photo_IG_data)
    all_tags = get_all_tag_data_from(individual_photo_IG_data)
    if photo_is_image?(individual_photo_IG_data) && all_tags.include?(tag)
      photo = create_photo(individual_photo_IG_data)
      add_tags_for_photo(photo, all_tags)
    end
  end

  def get_user_media_from_IG(instagram_id)
    user = get_current_user
    if @next_max_id == nil
      return HTTParty.get("https://api.instagram.com/v1/users/#{user.instagram_id}/media/recent/?access_token=#{user.access_token}")
    else
      return HTTParty.get("https://api.instagram.com/v1/users/#{user.instagram_id}/media/recent/?access_token=#{user.access_token}&max_id=#{@next_max_id}")
      # return the other data
    end
  end

  def extract_IG_data(response)
    json_object = JSON.parse(response.body)
    @next_max_id = json_object["pagination"]["next_max_id"]
    @photo_data = json_object["data"]
  end

  def get_photo_if_it_exists(individual_photo_IG_data)
    photo_url = get_URL(individual_photo_IG_data)
    Photo.find_by(url: photo_url)
  end

  def photo_is_image?(individual_photo_IG_data)
    individual_photo_IG_data["type"] == "image"
  end

  def create_photo(individual_photo_IG_data)
    photo = Photo.create!(
      user_id:                  @user.id,
      url:                      get_URL(individual_photo_IG_data),
      instagram_url:            individual_photo_IG_data['link'],
      instagram_creation_time:  individual_photo_IG_data['created_time']
    )
    return photo
  end

  def get_URL(individual_photo_IG_data)
    individual_photo_IG_data["images"]["standard_resolution"]["url"]
  end

  def get_all_tag_data_from(individual_photo_IG_data)
    return individual_photo_IG_data["tags"]
  end

  def add_tags_for_photo(photo, all_tags)
    return if all_tags.nil?
    all_tags.each do |tag_name|
      tag = find_or_create_tag(tag_name)
      PhotoTag.create(photo_id: photo.id, tag_id: tag.id)
    end
  end
end