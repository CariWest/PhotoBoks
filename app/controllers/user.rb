get '/user/new' do
  user = User.new
  erb :"user/_new", locals: { user: user }
end

get '/user/login' do
  user = User.new
  erb :"user/_login", locals: { user: user }
end

post '/user' do
  user = User.create(params[:user])

  if user.persisted?
    session[:id] = user.id
    redirect '/user'
  else
    erb :"user/_new", locals: { user: user }
  end
end

put '/user' do
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