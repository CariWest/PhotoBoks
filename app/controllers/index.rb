get '/' do
  user = User.new
  erb :index, locals: { user: user }
end

get '/user/new' do
  erb :"user/_new"
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

get '/user' do
  user = User.find(session[:id])
  puts user
  if user
    puts "this is the user home page"
    "hello world"
  end
end