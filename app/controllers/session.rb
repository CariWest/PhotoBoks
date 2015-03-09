get '/user/register' do
  user = User.new
  erb :"user/new", locals: { user: user }
end

get '/user/login' do
  erb :"user/login", locals: { errors: [], user: User.new }
end

post '/user/register' do
  user = User.new(params[:user])
  if user.save
    session[:id] = user.id
    redirect '/user'
  else
    # a user doesn't get an error if they don't put in a password...
    erb :"user/new", locals: { user: user }
  end
end

post '/user/login' do
  user = User.where(username: params[:username]).first
  authentication = user.authenticate(params[:password])
  errors = []

  if user == nil
    errors << "User does not exist"
    user = User.new
  elsif authentication == false
    errors << "Password does not match"
  end

  if errors.empty?
    session[:id] = user.id
    redirect '/user'
  else
    erb :"user/login", locals: { user: user, errors: errors }
  end
end

get '/user/logout' do
  session[:id] = nil
  redirect '/'
end