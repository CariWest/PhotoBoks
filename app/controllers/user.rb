get '/user' do
  user = User.find(session[:id])
  albums = user.albums
  if user
    erb :"user/index", locals: { user: user, albums: albums}
  end
end

get '/auth' do
  p params
end