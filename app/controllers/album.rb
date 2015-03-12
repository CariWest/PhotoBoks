get '/albums' do
end

get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do
  tag = find_or_create_tag(params[:tag])
  user = get_current_user(session[:id])
  params[:title]

  album = Album.new(title: params[:title], user_id: user.id, tag_id: tag.id)
  if album.save
    content_type :json
    { albumName: album.title, albumTag: album.tag.name, albumCover: album.cover, albumId: album.id  }.to_json
  else
    status 400
    # would like to render errors on page
  end
end

get '/albums/:id' do
  album = Album.find(params[:id])
  tag = album.tag

  # should this be in the post method...?
  if album.populated == false
    add_photos_to_database_if_new_and_contain_tag(tag.name)
    album.populated = true
    album.save
  end

  if album.photos.length >= 1
    album.cover = album.photos.last.url
    album.save
  end

  photos = album.photos.sort_by { |photo| photo.updated_at }.reverse

  # add logic for when a new photo has been added to the mix...

  # all_photos = get_photos_with_tag(tag.id)

  erb :"albums/index", locals: { album: album }
end

get '/albums/:id/edit' do
  album = Album.find(params[:id])
    form = erb :"/albums/edit", locals: { album: album }, layout: false
    content_type :json
    { form: form  }.to_json
  end

  put '/albums/:id' do
end

delete '/albums/:id' do
  Album.find(params[:id]).destroy
end

