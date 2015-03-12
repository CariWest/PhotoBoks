get '/user' do
  user = User.find(session[:id])
  albums = user.albums.sort_by { |album| album.updated_at }
  if user
    erb :"user/index", locals: { user: user, albums: albums}
  end
end

get '/instagram_auth' do
  redirect "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}&redirect_uri=http://127.0.0.1:9393/auth&response_type=code"
end

get '/auth' do
  p code = params['code']
  # need to remember to check for & parse errors
  response = HTTParty.post('https://api.instagram.com/oauth/access_token', {
    body: {
      client_id:      ENV['INSTAGRAM_CLIENT_ID'],
      client_secret:  ENV['INSTAGRAM_SECRET_KEY'],
      grant_type:     "authorization_code",
      redirect_uri:   "http://127.0.0.1:9393/auth",
      code:           code
    }
  })

  response_data = JSON.parse(response.body)
  access_token = response_data["access_token"]
  user_data = response_data["user"]

  user = get_user(user_data["username"])

  if user == nil
    user = create_user(user_data, access_token)
  end

  if user
    status 200
    session[:id] = user.id
    redirect '/user', locals: { user: user }
  else
    puts "user authorization fails"
  end
end

get '/user/logout' do
  session[:id] = nil
  redirect '/'
end