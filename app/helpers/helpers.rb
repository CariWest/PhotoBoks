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

  def add_photos_when_album_created(album_id)
    album = Album.find(params[:id])
    tag = album.tag.name
    user = User.find(session[:id])
    instagram_id = user.instagram_id

    response = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}")

    # response_data = JSON.parse(response.body)
    # photo_data = response_data["data"]

    photo_data = JSON.parse(response.body)["data"]

    puts "printing response data"
    photo_data.each do |individual_photo|
      all_tags = individual_photo["tags"]

      if data_is_image?(photo_data) && photo_contains_tag?(desired_tag, all_tags)
        add_photo_to_album(user.id, individual_photo)
      end

      # return if count == 5
      p individual_photo["tags"]
      # count += 1
    end
  end

  def photo_contains_tag?(desired_tag, all_tags)
    all_tags.each { |tag| return true if tag == desired_tag }
    return false
  end

  def add_photo_to_album(user_id, photo_data)
    Photo.create!(
      url:                individual_photo["link"],
      instagram_photo_id: individual_photo["id"],
      caption:            individual_photo["caption"],
      user_id:            user_id
    )
  end

  def photo_is_image?(photo_data)
    photo_data["type"] == "image"
  end

  def create_photo_tag_relationship(photo_id, tag_name)
    # if the tag already exists,
      # check to see if there's already a relationship
        # if yes, return?
        # if no, create a photo tag relationship
    # if the tag doesn't already exist
      # create the tag
      # create the photo tag relationship

      # this could be more straightforward... look at something Dave & I did?
      if Tag.find_by(tag: tag_name)
        tag = Tag.find_by(tag: tag_name)
      else
        tag = Tag.create(name: tag_name)
      end

      PhotoTag.create(tag_id: tag.id, photo_id: photo_id)
  end
end
    # MVP things to grab:
      # photo id, which is response_data["id"]
      # tags: response_data["tags"]
      # url: response_data["link"]
      # caption: response_data["caption"]["text"]
      # only images - type: response_data["type"] == "image"
    # Extra things to eventually grab:
      # likes