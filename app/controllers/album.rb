get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do
  tag = find_or_create_tag(params[:tag])
  user = get_current_user
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
  can_edit = (session[:id] == album.user.id)

  if album.populated == false
    populate_album_for_first_time(tag.name)
    album.update_attributes(populated: true)
  else
    check_for_new_photos(tag.name)
  end

  if album.photos.length >= 1
    album.cover = album.photos.last.url
    album.save
  end

  sorted_photos = get_sorted_photos(album.tag.name)

  erb :"albums/index", locals: { album: album, can_edit: can_edit, photos: sorted_photos }
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

