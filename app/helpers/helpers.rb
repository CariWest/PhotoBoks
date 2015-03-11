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

    p response_data = JSON.parse(response.body)



    # MVP things to grab:
      # photo id, which is response_data["id"]
      # tags: response_data["tags"]
      # url: response_data["link"]
      # caption: response_data["caption"]["text"]
      # only images - type: response_data["type"] == "image"
    # Extra things to eventually grab:
      # likes
  end

end