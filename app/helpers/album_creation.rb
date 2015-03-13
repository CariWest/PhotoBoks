# helpers do

#   def get_IG_data(response)
#     json_object = JSON.parse(response.body)
#     @next_max_id = json_object["pagination"]["next_max_id"]
#     @photo_data = json_object["data"]
#   end

#   def get_media_from_IG(instagram_id)
#     return HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}")
#   end

#   def add_photos_to_database_if_new_and_contain_tag(desired_tag)
#     user = get_current_user(session[:id])
#     response = get_media_from_IG(user.instagram_id)
#     photo_data = JSON.parse(response.body)["data"]

#     photo_data.each do |individual_photo|
#       next if photo_exists_in_db?(get_URL(individual_photo))

#       all_tags = individual_photo["tags"]
#       type = individual_photo["type"]
#       if photo_is_image?(type) && photo_contains_tag?(desired_tag, all_tags)
#         add_user_photo_to_db(user.id, individual_photo)
#         photo = Photo.all.last
#         all_tags = get_all_tags(all_tags)
#         set_tag_relationships_for_photo(photo, all_tags)
#       end
#     end
#   end

#   def photo_contains_tag?(desired_tag, all_tags)
#     all_tags.each do |tag|
#       return true if tag == desired_tag
#     end
#     false
#   end

#   def photo_is_image?(type)
#     type == "image"
#   end

#   def add_user_photo_to_db(user_id, individual_photo)
#     photo = Photo.create!(
#       user_id:                  user_id,
#       url:                      get_URL(individual_photo),
#       # throwing error for really long captions...
#       # caption:                  individual_photo['caption']['text'],
#       instagram_url:            individual_photo['link'],
#       instagram_creation_time:  individual_photo['created_time']
#     )
#     return photo
#   end

#   def photo_exists_in_db?(photo_url)
#     Photo.find_by(url: photo_url) ? true : false
#   end

#   def create_photo_tag_relationship(photo_id, tag_id)
#     PhotoTag.create(tag_id: tag_id, photo_id: photo_id)
#   end

#   def get_all_tags(all_tags)
#     return if all_tags.empty?
#     tags = all_tags.map do |tag_name|
#       find_or_create_tag(tag_name)
#     end
#     return tags
#   end

#   def set_tag_relationships_for_photo(photo, all_tags)
#     all_tags.each do |tag|
#       create_photo_tag_relationship(photo.id, tag.id)
#     end
#   end

#   def get_URL(photo_data)
#     images = photo_data["images"]
#     standard_image = images["standard_resolution"]
#     return standard_image["url"]
#   end

#   def check_for_new_photos_with_tag(desired_tag)
#     user = get_current_user(session[:id])
#     response = get_media_from_IG(user.instagram_id)

#     photo_data = JSON.parse(response.body)["data"]

#     photo_data.each do |individual_photo|
#       return if photo_exists_in_db?(get_URL(individual_photo))

#       all_tags = individual_photo["tags"]
#       type = individual_photo["type"]
#       if photo_is_image?(type) && photo_contains_tag?(desired_tag, all_tags)
#         photo = add_user_photo_to_db(user.id, individual_photo)
#         # photo = Photo.all.last
#         all_tags = get_all_tags(all_tags)
#         set_tag_relationships_for_photo(photo, all_tags)
#       end
#     end
#   end

# end

