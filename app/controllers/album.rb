get '/albums' do
end

get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do
  p params
  p tag = get_tag(params[:tag])
  p session[:id]
  p user = get_current_user(session[:id])

  album = Album.new(title: params[:title], user_id: user.id, tag_id: tag.id, tag_id: tag.id)

  if album.save
    content_type :json
    { albumName: album.title, albumTag: album.tag.name, albumCover: album.cover  }.to_json
  else
    status 400
    # render errors on page
  end
end

put '/album/:id' do
end

delete '/album/:id' do
end

