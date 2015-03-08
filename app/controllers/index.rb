get '/' do
  erb :index
end

get '/users/new' do
  erb :"users/_new"
end