get '/user' do
  user = User.find(session[:id])
  p albums = user.albums.sort_by { |album| album.updated_at }.reverse
  if user
    erb :"user/index", locals: { user: user, albums: albums}
  end
end

get '/instagram_auth' do
  redirect "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}&redirect_uri=#{ENV['IG_AUTHORIZE_REDIRECT']}&response_type=code"
end

get '/auth' do
  p params
  code = params['code']
  # need to remember to check for & parse errors
  p response = HTTParty.post('https://api.instagram.com/oauth/access_token', {
    body: {
      client_id:      ENV['INSTAGRAM_CLIENT_ID'],
      client_secret:  ENV['INSTAGRAM_SECRET_KEY'],
      grant_type:     "authorization_code",
      redirect_uri:   ENV['IG_AUTHORIZE_REDIRECT'],
      code:           code
    }
  })
  p "BOOM"
  p response_data = JSON.parse(response.body)
  p access_token = response_data["access_token"]
  p user_data = response_data["user"]
  p
  puts "HERE"
  user = get_user(user_data["username"])

  if user == nil
    user = create_user(user_data, access_token)
  end
  puts "AFTER USER CREATE STMT"
  if user
    puts "INSIDE IF"
    status 200
    session[:id] = user.id
    redirect '/user', locals: { user: user }
  else
    puts "INSIDE ELSE OF IF"
    puts "user authorization fails"
  end
end

get '/user/logout' do
  session[:id] = nil
  redirect '/'
end