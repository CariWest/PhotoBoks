get '/albums' do
end

get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do
  tag = get_tag(params[:tag])
  session[:id]
  user = get_current_user(session[:id])

  album = Album.new(title: params[:title], user_id: user.id, tag_id: tag.id, tag_id: tag.id)
  if album.save
    p "HERE"
    p album.id
    content_type :json
    { albumName: album.title, albumTag: album.tag.name, albumCover: album.cover, albumId: album.id  }.to_json
  else
    status 400
    # render errors on page
  end
end

get '/albums/:id' do
  album = Album.find(params[:id])
  erb :"albums/index", locals: { album: album }
end

get '/album/:id/edit' do
end

put '/album/:id' do
end

delete '/album/:id' do
  puts "inside delete"
end

