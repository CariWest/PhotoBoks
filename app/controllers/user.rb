get '/user/new' do
  user = User.new
  erb :"user/_new", locals: { user: user }
end

get '/user/login' do
  erb :"user/_login"
end

post '/user/register' do
  user = User.new(params[:user])
  # the password isn't being converted into a password hash
  puts "does this go in post user?"
  if user.save
    session[:id] = user.id
    redirect '/user'
  else
    erb :"user/_new", locals: { user: user }
  end
end

post '/user/login' do
  user = User.find(username: params[:username])
  # the user isn't being found

  puts "outside user authentication"
  if user.authenticate(params[:password])
    puts "inside user authentication!!"
    session[:id] = user.id
    redirect '/user'
  else
    # render errors
    erb :"user/_login"
  end

  # if they log in successfully
    # give them a session id
  # else
    # rerender the page with an error message
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