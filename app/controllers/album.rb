get '/albums' do
end

get '/albums/new' do
  content_type :json
  erb :"albums/new".to_json
end

post '/albums' do
end

put '/album/:id' do
end

delete '/album/:id' do
end

