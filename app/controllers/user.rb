get '/user' do
  user = User.find(session[:id])
  albums = user.albums
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
       #maybe need to pass as string?
      client_secret:  ENV['INSTAGRAM_SECRET_KEY'],
      grant_type:     "authorization_code",
      redirect_uri:   "http://127.0.0.1:9393/auth",
      code:           code
    }
  })

  p response_data = JSON.parse(response.body)
  p access_token = response_data["access_token"]
  p user_data = response_data["user"]

  if user = User.find_by(username: user_data["username"])
    session[:id] = user.id
    redirect '/user', locals: { user: user }
  else
    user = User.new(
      username: user_data["username"],
      full_name: user_data["full_name"],
      bio: user_data["bio"],
      website: user_data["website"],
      profile_picture: user_data["profile_picture"],
      instagram_id: user_data["id"],
      access_token: access_token
    )

    if user.save
      status 200
      session[:id] = user.id
      redirect '/user', locals: { user: user }
    else
      puts "save failed"
    end
  end
end