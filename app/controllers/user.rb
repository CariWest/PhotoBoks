get '/user/new' do
  user = User.new
  erb :"user/_new", locals: { user: user }
end

get '/user/login' do
  erb :"user/_login"
end

post '/user/register' do
  user = User.new(params[:user])
  if user.save
    session[:id] = user.id
    redirect '/user'
  else
    # a user doesn't get an error if they don't put in a password...
    erb :"user/_new", locals: { user: user }
  end
end

post '/user/login' do
  user = User.find(username: params[:username])
  authentication = user.authenticate(params[:password])

  errors = []

  if user == nil
    errors << "User does not exist"
  elsif authentication == false
    errors << "Password does not match"
  end

  if errors.empty?
    session[:id] = user.id
    redirect '/user'
  else
    erb :"user/_login", locals: { errors: errors }
  end
end

get '/user' do
  user = User.find(session[:id])
  if user
    erb :"user/index", locals: { user: user}
  end
end

get '/user/logout' do
  session[:id] = nil
  redirect '/'
end